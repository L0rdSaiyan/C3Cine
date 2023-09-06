public with sharing class FuncionariosService {
    
    public static void funcionarioTriggerHandlerBeforeInsertRank(List<Funcionario__c> funcionarios){

        for(Funcionario__c funcionario : funcionarios){

            if(funcionario.Ingressos_Vendidos__c == 10){

                funcionario.Ranks__c = 'Competente';

            }else if(funcionario.Ingressos_Vendidos__c == 20){

                funcionario.Ranks__c = 'Experiente';


            }else if(funcionario.Ingressos_Vendidos__c == 30){

                funcionario.Ranks__c = 'C3Ceiro';

            }else if(funcionario.Ingressos_Vendidos__c == 40){

                funcionario.Ranks__c = 'Líder de Equipe';

            }else if(funcionario.Ingressos_Vendidos__c >=50 ){

                funcionario.Ranks__c = 'Funcionário do Mês';	

            }


        }


    }

    public static void validarNumeroDeIngressosTriggerHandler(List<Funcionario__c> funcionarios){

        for(Funcionario__c funcionario : funcionarios){


            if(funcionario.Ingressos_Vendidos__c <0){

                funcionario.Ingressos_Vendidos__c.addError('Valores negativos não são permitidos!');

            }


        }


    }


}