public with sharing class ClientesSelector {
 
    public static List<Cliente__c> consultarClientes(List<Id> clientesId ){

        list<Cliente__c> clientes = [SELECT Name, Id, Apresentou_Carteirinha__c, Pessoa_com_DeficiEncia_PCD__c, estudante__c
                                   FROM Cliente__c 
                                   WHERE Id IN :clientesId]; 
    
        return clientes;
    
       }

}