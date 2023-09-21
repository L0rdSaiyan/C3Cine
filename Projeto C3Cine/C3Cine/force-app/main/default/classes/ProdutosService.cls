public with sharing class ProdutosService {
    
public static void defineStatusTriggerHandler(List<Produtos__c> produtos){
    
    for(Produtos__c prod : produtos){
        if(prod.Quantidade_em_estoque__c <= 0){
            prod.Status_do_Produto__c = 'Em falta';
        }
        else if(prod.Quantidade_em_estoque__c <> 0){
            prod.Status_do_Produto__c = 'Em estoque';
        }
    }

}


}