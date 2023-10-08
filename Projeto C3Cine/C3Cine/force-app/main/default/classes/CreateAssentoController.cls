global with sharing class CreateAssentoController {
   
    @AuraEnabled
    public static void criarAssento(String name, String id){
     
        Assento__c assento = new Assento__c();
        assento.Name = name;
        assento.Ingresso__c = id;
    
        insert assento;
    }
    
    @AuraEnabled
    public static Boolean validarAssentoDisponivelParaSala(String nomeAssento, Id nomeSala) {
        Boolean resposta = false;
    
        // Seleciona os assentos indisponíveis com o nome especificado para a sala informada.
        List<Assento__c> assentos = CreateAssentoSelector.selecionarAssentosIndisponiveis(nomeAssento, nomeSala);
    
        if (!assentos.isEmpty()) {
            resposta = true;
        }
    
        return resposta;
    }

    @AuraEnabled
    public static List<String> selecionarAssentosPorSala(String nomeSala) {
        List<String> nomesAssentos = new List<String>();
    
        List<Assento__c> assentos = [SELECT Name FROM Assento__c WHERE Sala__c = :nomeSala];
    
        for (Assento__c assento : assentos) {
            nomesAssentos.add(assento.Name);
        }
    
        return nomesAssentos;
    }
    

}