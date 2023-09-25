public with sharing class SalaSelector {
   
    public static List<Sala__c> selecionarSalas(List<Id> salasToSelect){

        List<Sala__c> salas = [SELECT Name, Id, Quantidade_de_Assentos__c
                              FROM Sala__c
                              WHERE Id IN: salasToSelect];
    
        return salas;
    
       }
    
    


}