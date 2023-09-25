public with sharing class IngressoService {

    // Método de trigger Before Insert para atualizar o número de ingressos vendidos por funcionários.
    public static void ingressoTriggerHandlerBeforeInsert(List<Ingressos__c> ingressos) {
        List<Id> funcionariosToUpdate = new List<Id>();

        for (Ingressos__c ingresso : ingressos) {
            if (ingresso.Funcionario_que_vendeu_o_ingresso__c != null) {
                funcionariosToUpdate.add(ingresso.Funcionario_que_vendeu_o_ingresso__c);
            }
        }

        if (!funcionariosToUpdate.isEmpty()) {
            List<Funcionario__c> funcionarios = FuncionarioSelector.selecionarFuncionario(funcionariosToUpdate);

            for (Funcionario__c funcionario : funcionarios) {
                if (funcionario.Cargo__c == 'Caixa de cinema') {
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

    // Método de trigger Before Insert para validar se o filme está em cartaz.
    public static void ingressoTriggerHandlerValidarFilme(List<Ingressos__c> ingressos) {
        List<Id> filmesToUpdate = new List<Id>();

        // Desenvolvendo a lógica para verificar se o filme está fora de cartaz.
        for (Ingressos__c ingresso : ingressos) {
            filmesToUpdate.add(ingresso.Filme__c);
        }

        List<Filme__c> filmes = FilmesSelector.consultarFilmePorId(filmesToUpdate);

        for (Filme__c filme : filmes) {
            if (filme.Esta_em_Cartaz__c == 'Não') {
                for (Ingressos__c ingresso : ingressos) {
                    ingresso.Filme__c.addError('Não foi possível efetuar o cadastro do ingresso pois o filme está fora de cartaz!');
                }
            }
        }
    }

    // Método invocável para apagar ingressos antigos.
    @invocableMethod(Label = 'Apaga ingressos antigos')
    public static void apagarIngressosAntigosFlow() {
        List<Ingressos__c> ingressosAntigos = IngressoSelector.consultarIngressosAntigos();
        delete ingressosAntigos;
    }

    // Método para reduzir a quantidade de assentos disponíveis em uma sala quando um ingresso é criado.
    public static void reduzirAssentosDeSala(List<Ingressos__c> ingressos) {
        List<Id> salasToUpdate = new List<Id>();

        for (Ingressos__c ingresso : ingressos) {
            salasToUpdate.add(ingresso.Sala__c);
        }

        List<Sala__c> salas = SalasSelector.selecionarAssentoSalas(salasToUpdate);

        for (Sala__c sala : salas) {
            sala.Quantidade_de_Assentos__c -= 1;
        }

        update salas;
    }

    // Método para validar o valor do ingresso com base no dia da semana e do cliente.
    public static void validarValorDoIngresso(List<Ingressos__c> ingressos) {
        List<Id> idClientes = new List<Id>();
        DateTime dt = DateTime.newInstance(System.today(), Time.newInstance(0, 0, 0, 0));
        String dayOfWeek = dt.format('u');

        for (Ingressos__c ingresso : ingressos) {
            idClientes.add(ingresso.Cliente__c);
        }

        List<Cliente__c> clientes = ClientesSelector.consultarClientes(idClientes);

        for (Cliente__c cliente : clientes) {
            // Se o dia da semana for terça, quarta ou quinta, o valor do ingresso é R$15.00
            if (dayOfWeek == '2' || dayOfWeek == '3' || dayOfWeek == '4') {
                for (Ingressos__c ingresso : ingressos) {
                    ingresso.Valor_do_Ingresso__c = 15.00;
                }
                return; // Retorna para evitar outras condições
            }

            if (cliente.Pessoa_com_DeficiEncia_PCD__c == 'Sim') {
                for (Ingressos__c ingresso : ingressos) {
                    ingresso.Valor_do_Ingresso__c = 18.00;
                }
            } else if (cliente.estudante__c == 'Sim' && cliente.estudante__c == 'Sim') {
                for (Ingressos__c ingresso : ingressos) {
                    ingresso.Valor_do_Ingresso__c = 15.00;
                }
            } else {
                for (Ingressos__c ingresso : ingressos) {
                    ingresso.Valor_do_Ingresso__c = 30.00;
                }
            }
        }
    }

    // Método para validar a quantidade de assentos disponíveis em uma sala.
    public static void validarQuantidadeAssentos(List<Ingressos__c> ingressos) {
        List<Id> salasToSelect = new List<Id>();

        for (Ingressos__c ingresso : ingressos) {
            salasToSelect.add(ingresso.Sala__c);
        }

        List<Sala__c> salas = SalaSelector.selecionarSalas(salasToSelect);

        for (Sala__c sala : salas) {
            if (sala.Quantidade_de_Assentos__c < 0) {
                for (Ingressos__c ingresso : ingressos) {
                    ingresso.Sala__c.addError('Não foi possível efetuar o cadastro do ingresso na sala ' + sala.Name + ', pois a mesma já não tem assentos disponíveis');
                }
            }
        }
    }

    // Método para aumentar a quantidade de assentos disponíveis em uma sala quando um ingresso é excluído.
    public static void aumentarAssentosDisponiveisTriggerHandlerBeforeDelete(List<Ingressos__c> ingressos) {
        List<Id> salasToUpdate = new List<Id>();

        for (Ingressos__c ingresso : ingressos) {
            salasToUpdate.add(ingresso.Sala__c);
        }

        List<Sala__c> salas = SalaSelector.selecionarSalas(salasToUpdate);

        for (Sala__c sala : salas) {
            sala.Quantidade_de_Assentos__c += 1;
        }

        update salas;
    }

    // Método para validar se o funcionário associado ao ingresso é da bilheteria.
    public static void validarFuncionarioPIngresso(List<Ingressos__c> ingressos) {
        List<Id> funcionariosId = new List<Id>();

        for (Ingressos__c ingresso : ingressos) {
            funcionariosId.add(ingresso.Funcionario_que_vendeu_o_ingresso__c);
        }

        List<Funcionario__c> funcionariosToCheck = FuncionarioSelector.selecionarFuncionario(funcionariosId);

        for (Funcionario__c funcionario : funcionariosToCheck) {
            if (funcionario.Cargo__c != 'Caixa de Cinema') {
                for (Ingressos__c ingresso : ingressos) {
                    ingresso.Funcionario_que_vendeu_o_ingresso__c.addError('O funcionário não faz parte da bilheteria');
                }
            }
        }
    }
    
    public static void deleterReversaDeAssento(List<Ingressos__c> ingressos){

	List<Id> assentosToDelete = new List<Id>();
        
        for(Ingressos__c ingresso : ingressos){


            assentosToDelete.add(ingresso.Assento__c);
            
}
        
        List<Assento__c> assentos = [SELECT Id 
                                    FROM Assento__c
                                    WHERE Id IN: assentosToDelete];
        delete assentos;
        
        
}

    // O método abaixo foi transferido para a classe CreateAssentoController.
    // public static void validarAssentoDisponivelParaSala(List<Ingressos__c> ingressos) {
    //     List<Id> salas = new List<Id>();
        
    //     // Coletar IDs de salas dos ingressos
    //     for (Ingressos__c ingresso : ingressos) {
    //         salas.add(ingresso.Sala__c);
    //     }
    
    //     // Consultar todos os assentos relacionados às salas dos ingressos
    //     List<Assento__c> assentos = [SELECT Id, Name, Sala__c 
    //                                   FROM Assento__c
    //                                   WHERE Sala__c IN :salas];
    
    //     Map<Id, Set<String>> salaAssentosMap = new Map<Id, Set<String>>();
        
    //     // Construir um mapa de salas para nomes de assentos associados
    //     for (Assento__c assento : assentos) {
    //         if (!salaAssentosMap.containsKey(assento.Sala__c)) {
    //             salaAssentosMap.put(assento.Sala__c, new Set<String>());
    //         }
    //         salaAssentosMap.get(assento.Sala__c).add(assento.Name);
    //     }
    
    //     // Validar os assentos selecionados nos ingressos
    //     for (Ingressos__c ingresso : ingressos) {
    //         if (salaAssentosMap.containsKey(ingresso.Sala__c) &&
    //             salaAssentosMap.get(ingresso.Sala__c).contains(ingresso.teste_assento__c)) {
    //             ingresso.teste_assento__c.addError('Você não pode selecionar essa cadeira pois ela já foi selecionada por outro usuário');
    //         }
    //     }
    // }
}