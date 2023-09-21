public with sharing class CreateAssentoSelector {
    
        public static List<Assento__c> selecionarAssentosIndisponiveis(String nomeAssento, Id nomeSala){


            List<Assento__c> assentos = [ SELECT Id, Name, Sala__r.Name
            FROM Assento__c
            WHERE Name = :nomeAssento AND Sala__c = :nomeSala];

            return assentos;

        }

}