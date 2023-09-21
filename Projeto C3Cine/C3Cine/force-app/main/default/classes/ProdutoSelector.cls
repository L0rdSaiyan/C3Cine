public with sharing class ProdutoSelector {
    
    public static List<Produtos__c> selecionarProdutosEmEstoque(List<Id> estoqueToUpdate){

List<Produtos__c> produtos = [SELECT Name, Id,Quantidade_em_estoque__c,Status_do_Produto__c,Valor_do_Produto__c
FROM Produtos__c
WHERE Id IN  :estoqueToUpdate];

return produtos;
    }
    
}