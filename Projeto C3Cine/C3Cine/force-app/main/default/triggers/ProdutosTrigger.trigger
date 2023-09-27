trigger ProdutosTrigger on Produtos__c (before insert, before update) {
     switch on Trigger.OperationType {
        when BEFORE_INSERT {
            ProdutosService.defineStatusTriggerHandler(Trigger.new);
            ProdutosService.produtosTriggerHandlerValidaEstoque(Trigger.new);
            
        }
        when BEFORE_UPDATE {
            ProdutosService.defineStatusTriggerHandler(Trigger.new);
            ProdutosService.produtosTriggerHandlerValidaEstoque(Trigger.new);
        }
     }
}