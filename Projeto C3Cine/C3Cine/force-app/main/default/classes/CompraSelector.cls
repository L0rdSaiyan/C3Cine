public with sharing class CompraSelector {
    
    public static List<Compra__c> selecionarProdutosEmEstoque(List<Id> estoqueToUpdate){

List<Compra__c> compras = [SELECT Name, Id,Produto__c,Quantidade__c,Recibo__c
FROM Compra__c
WHERE Id IN :estoqueToUpdate];

return compras;
    }
}