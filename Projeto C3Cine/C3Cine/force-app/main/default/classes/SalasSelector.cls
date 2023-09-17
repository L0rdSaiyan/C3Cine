public with sharing class SalasSelector {
   
    public static List<Sala__c> selecionarAssentoSalas(List<Id> salasToUpdate){

       List<Sala__c> salas = [SELECT Name, Id, Quantidade_de_Assentos__c
       FROM Sala__c
       WHERE Id IN :salasToUpdate];

    return salas;

    }

}