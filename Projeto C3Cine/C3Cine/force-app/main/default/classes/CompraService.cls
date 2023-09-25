public with sharing class CompraService {

    public static void reduzirProdutosDoEstoque(List<Compra__c> comprasprodutos){
        List<Id> estoqueToUpdate = new List<Id>();
    
        for(Compra__c compra : comprasprodutos){
    
            estoqueToUpdate.add(compra.Produto__c);
    
        }
        
        List<Produtos__c> produtos = [SELECT Id, Name, Quantidade_em_estoque__c
                                    FROM Produtos__c
                                    WHERE Id IN : estoqueToUpdate];
        // List<Compra__c> compra = [SELECT id,Name,Quantidade__c
        //                             FROM Compra__c
        //                             WHERE id In : estoqueToUpdate];

        for(Produtos__c produto : produtos){
        for(Compra__c compra : comprasprodutos){
            produto.Quantidade_em_estoque__c -= compra.Quantidade__c;
     
        }
        
    }
    update produtos;
}
    public static void compraTriggerHandlerCalculaValorTotal(List<Compra__c> compras){
        List<Id> listaProdutos = new List<Id>();

        for (Compra__c comp : compras) {
            listaProdutos.add(comp.Produto__c);
        }

        List<Produtos__c> produtos = [SELECT Id, Name, Valor_do_Produto__c
                                      FROM Produtos__c
                                      WHERE Id IN : listaProdutos];

        for (Compra__c comp : compras) {
            for(Produtos__c prod : produtos){
                comp.Valor_Total__c = comp.Quantidade__c * prod.Valor_do_Produto__c;
            }
        }
    } 
    
    public static void compraTriggerHandlerValidaQuantidade(List<Compra__c> compras) {
        List<Id> listaProdutos = new List<Id>();
    
        for (Compra__c comp : compras) {
            listaProdutos.add(comp.Produto__c);
        }
    
        Map<Id, Produtos__c> produtosMap = new Map<Id, Produtos__c>([SELECT Id, Quantidade_em_estoque__c
                                                                       FROM Produtos__c
                                                                       WHERE Id IN :listaProdutos]);
    
        for (Compra__c compra : compras) {
            if (produtosMap.containsKey(compra.Produto__c)) {
                Produtos__c produto = produtosMap.get(compra.Produto__c);
                if (compra.Quantidade__c > produto.Quantidade_em_estoque__c) {
                    compra.Quantidade__c.addError('A quantidade da compra não pode ser maior que a quantidade em estoque do produto.');
                }
            }
        }
    }

}