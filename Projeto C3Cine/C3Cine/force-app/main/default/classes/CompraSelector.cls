public with sharing class CompraSelector {
    
    public static List<Compra__c> selecionarProdutosEmEstoque(List<Id> estoqueToCompras){

List<Compra__c> compras = [SELECT Name, Id,Produto__c,Quantidade__c,Valor_Total__c
FROM Compra__c
WHERE Id IN :estoqueToCompras];

return compras;
    }
}