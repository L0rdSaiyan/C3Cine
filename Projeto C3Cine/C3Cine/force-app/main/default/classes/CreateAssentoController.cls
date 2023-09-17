global with sharing class CreateAssentoController {
   
@AuraEnabled
public static void criarAssento(String name, String id){
 
    Assento__c assento = new Assento__c();
    assento.Name = name;
    assento.Ingresso__c = id;

    insert assento;

}

}