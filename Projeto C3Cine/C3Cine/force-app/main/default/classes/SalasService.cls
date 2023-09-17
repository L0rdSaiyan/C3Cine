public with sharing class SalasService {
   
    public static void aplicarAssentosPadraoParaSalaTriggerHandler(List<Sala__c> salas){

        for(Sala__c sala : salas){

            if(sala.Quantidade_de_Assentos__c != 50){

                sala.Quantidade_de_Assentos__c = 50;

            }

        }


    }

 


}