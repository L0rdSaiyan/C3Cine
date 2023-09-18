public with sharing class IngressoService {

    public static void ingressoTriggerHandlerBeforeInsert(List<Ingressos__c> ingressos) {

        List<Id> funcionariosToUpdate = new List<Id>();

        for (Ingressos__c ingresso : ingressos) {

            if (ingresso.Funcionario_que_vendeu_o_ingresso__c != null) {
                funcionariosToUpdate.add(ingresso.Funcionario_que_vendeu_o_ingresso__c);
            }
        }

        if (!funcionariosToUpdate.isEmpty()) {

            List<Funcionario__c> funcionarios = IngressoSelector.selecionarFuncionario(funcionariosToUpdate);
            

            for (Funcionario__c funcionario : funcionarios) {

                if(funcionario.Cargo__c == 'Caixa de cinema'){
                if (funcionario.Ingressos_Vendidos__c == null) {
                    funcionario.Ingressos_Vendidos__c = 1;
                } else {
                    funcionario.Ingressos_Vendidos__c += 1;
                }
                update funcionarios;
            }
        }

        }
    }

    public static void ingressoTriggerHandlerValidarFilme(List<Ingressos__c> ingressos){

            List<Id> filmesToUpdate = new List<Id>();

            //Desenvolvendo a lógica de n poder adicionar filme fora de cartaz.
            for(Ingressos__c ingresso : ingressos){

                filmesToUpdate.add(ingresso.Filme__c);

            }

            List<Filme__c> filmes = IngressoSelector.consultarFilmePorId(filmesToUpdate);

            for(Filme__c filme : filmes){

                if(filme.Esta_em_Cartaz__c == 'Não'){

                    for(Ingressos__c ingresso : ingressos){


                        ingresso.Filme__c.addError('Não foi possível efetuar o cadastro do ingresso pois o filme está fora de cartaz!');

                    }

                }
                
            }

    }

    @invocableMethod(Label = 'Apaga ingressos antigos')
    public static void apagarIngressosAntigosFlow(){

        List<Ingressos__c> ingressosAntigos = IngressoSelector.consultarIngressosAntigos();

        delete ingressosAntigos;


    }


    public static void reduzirAssentosDeSala(List<Ingressos__c> ingressos){

        List<Id> salasToUpdate = new List<Id>();

        for(Ingressos__c ingresso : ingressos){


            salasToUpdate.add(ingresso.Sala__c);

        }


        List<Sala__c> salas = SalasSelector.selecionarAssentoSalas(salasToUpdate);

        for(Sala__c sala : salas){

            sala.Quantidade_de_Assentos__c -=1;

        }

        update salas;


    }


    public static void validarValorDoIngresso(List<Ingressos__c> ingressos){

        List<Id> idClientes = new List<Id>();
        DateTime dt = DateTime.newInstance(System.today(), Time.newInstance(0,0,0,0));
        String dayOfWeek = dt.format('u');

        for( Ingressos__c ingresso : ingressos){

        idClientes.add(ingresso.Cliente__c);

        }

        List<Cliente__c> clientes = IngressoSelector.consultarClientes(idClientes);

        for(Cliente__c cliente : clientes){


            //If isolado para evitar conflitos com os outros if's, pois se ele fosse apenas mais um else if, ele não iria aplicar o desconto para pessoas PCD
            if(dayOfWeek == '2' || dayOfWeek == '3' || dayOfWeek == '4'){

                for(Ingressos__c ingresso: ingressos){

                    ingresso.Valor_do_Ingresso__c = 15.00;

                }

                return; // return para evitar que o ingresso caia nas outras condicionais

            }
            

            if(cliente.Pessoa_com_DeficiEncia_PCD__c == 'Sim'){

                for(Ingressos__c ingresso : ingressos){

                    ingresso.Valor_do_Ingresso__c = 18.00;
                }

            }else if(cliente.estudante__c == 'Sim' && cliente.estudante__c == 'Sim' ){

                for(Ingressos__c ingresso : ingressos){

                    ingresso.Valor_do_Ingresso__c = 15.00;
                }
            }else{

                for(Ingressos__c ingresso : ingressos){

                    ingresso.Valor_do_Ingresso__c = 30.00;
                }


            }


        }

    }

    public static void validarQuantidadeAssentos(List<Ingressos__c> ingressos){

        List<Id> salasToSelect = new List<Id>();

        for(Ingressos__c ingresso : ingressos){

            salasToSelect.add(ingresso.Sala__c);

        }

        List<Sala__c> salas = IngressoSelector.selecionarSalas(salasToSelect);

        for(Sala__c sala : salas){

            if(sala.Quantidade_de_Assentos__c <0 ){

                for(Ingressos__c ingresso : ingressos){

                    ingresso.Sala__c.addError('Não foi possível efetuar o cadastro do ingreso na sala '+sala.Name+', pois a mesma já não tem assentos disponíveis');

                }

            }

        }

    }


    public static void aumentarAssentosDisponiveisTriggerHandlerBeforeDelete(List<Ingressos__c> ingressos){

        List<Id> salasToUpdate = new List<Id>();

        for(Ingressos__c ingresso : ingressos){

            salasToUpdate.add(ingresso.Sala__c);

        }


        List<Sala__c> salas = IngressoSelector.selecionarSalas(salasToUpdate);

        for(Sala__c sala : salas){

            sala.Quantidade_de_Assentos__c +=1;

                }

                update salas;

    }



    public static void validarFuncionarioPIngresso(List<Ingressos__c> ingressos){

        List<Id> funcionariosId = new List<Id>();

        for(Ingressos__c ingresso: ingressos){

            funcionariosId.add(ingresso.Funcionario_que_vendeu_o_ingresso__c);

        }

        List<Funcionario__c> funcionariosToCheck = [SELECT Id, Name, Cargo__c
                                                    FROM Funcionario__c
                                                    WHERE Id IN : funcionariosId];

        for(Funcionario__c funcionario : funcionariosToCheck){

            if(funcionario.Cargo__c != 'Caixa de Cinema'){

                for(Ingressos__c ingresso : ingressos){

                        ingresso.Funcionario_que_vendeu_o_ingresso__c.addError('O funcionário não faz parte da bilheteria');

                }

            }

        }


    }

}