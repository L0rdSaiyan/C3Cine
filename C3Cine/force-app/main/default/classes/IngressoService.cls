public with sharing class IngressoService {

    public static void ingressoTriggerHandlerBeforeInsert(List<Ingressos__c> ingressos) {

        List<Id> funcionariosToUpdate = new List<Id>();

        for (Ingressos__c ingresso : ingressos) {

            if (ingresso.Funcionario_que_vendeu_o_ingresso__c != null) {
                funcionariosToUpdate.add(ingresso.Funcionario_que_vendeu_o_ingresso__c);
            }
        }

        if (!funcionariosToUpdate.isEmpty()) {

            List<Funcionario__c> funcionarios = [SELECT Id, Name, Ingressos_Vendidos__c, CPF__c, Email__c,Cargo__c
                                                  FROM Funcionario__c
                                                  WHERE Id IN :funcionariosToUpdate];

            for (Funcionario__c funcionario : funcionarios) {
                if (funcionario.Ingressos_Vendidos__c == null) {
                    funcionario.Ingressos_Vendidos__c = 1;
                } else {
                    funcionario.Ingressos_Vendidos__c += 1;
                }
            }

            update funcionarios;
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

}