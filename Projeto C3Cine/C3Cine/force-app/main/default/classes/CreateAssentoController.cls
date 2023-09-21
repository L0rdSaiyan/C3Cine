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

    List<Assento__c> assentos = CreateAssentoSelector.selecionarAssentosIndisponiveis(nomeAssento, nomeSala);

    if (!assentos.isEmpty()) {
        resposta = true;
    }

    return resposta;
}




}