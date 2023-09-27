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
                if(comp.Valor_Total__c >= 50){
                    comp.Valor_Total__c = comp.Valor_Total__c * 0.85;
                }
            }
        }
    } 
    
    public static void compraTriggerHandlerValidaQuantidade(List<Compra__c> compras) {
        List<Id> listaProdutos = new List<Id>();
    
        for (Compra__c comp : compras) {
            listaProdutos.add(comp.Produto__c);
        }
    
        List<Produtos__c> produtos = [SELECT Id, Valor_do_Produto__c, Quantidade_em_estoque__c
                                      FROM Produtos__c 
                                      WHERE Id 
                                      IN : listaProdutos];
        

        for(Compra__c comp : compras) {
            for (Produtos__c prod : produtos) {
                
                if(comp.Quantidade__c > prod.Quantidade_em_estoque__c){
                    comp.Quantidade__c.addError('Nosso estoque é limitado, você só pode escolher até '
                     + prod.Quantidade_em_estoque__c + ' itens');
                }
            }
        }
    }

}