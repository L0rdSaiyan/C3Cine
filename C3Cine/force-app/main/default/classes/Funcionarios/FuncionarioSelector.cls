public with sharing class FuncionarioSelector {
    

    public static List<Funcionario__c> selecionarTodosOsFuncionarios(){

        List<Funcionario__c> funcionarios = [SELECT Name, Id, Ranks__c, Ingressos_Vendidos__c 
                                            FROM Funcionario__c];

        return funcionarios;

    }



}