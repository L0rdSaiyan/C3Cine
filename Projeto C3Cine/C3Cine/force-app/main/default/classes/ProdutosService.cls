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

public static void reduzirProdutosDoEstoque(List<Compra__c> comprasprodutos){
    List<Id> estoqueToUpdate = new List<Id>();

    for(Compra__c compra : comprasprodutos){

        estoqueToUpdate.add(compra.Produto__c);

    }
    
    List<Produtos__c> produtos = [SELECT Id, Name, Quantidade_em_estoque__c
                                FROM Produtos__c
                                WHERE Id IN : estoqueToUpdate];

    for(Produtos__c produto : produtos){

        produto.Quantidade_em_estoque__c -=1;

    }

    update produtos;

}


}