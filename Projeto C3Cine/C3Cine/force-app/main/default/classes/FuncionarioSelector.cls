public with sharing class FuncionarioSelector {
    

    public static List<Funcionario__c> selecionarTodosOsFuncionarios(){

        List<Funcionario__c> funcionarios = [SELECT Name, Id, Ranks__c, Ingressos_Vendidos__c 
                                            FROM Funcionario__c];

        return funcionarios;

    }

    public static List<Funcionario__c> selecionarFuncionario(List<Id> funcionariosToUpdate){

        List<Funcionario__c> funcionarios = [SELECT Id, Name, Ingressos_Vendidos__c, CPF__c, Email__c, Cargo__c
        FROM Funcionario__c
        WHERE Id IN :funcionariosToUpdate];
    
        return funcionarios;
    
    
       }


}