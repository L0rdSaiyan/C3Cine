trigger ComprasTrigger on Compra__c (before insert,before update, after insert) {

    switch on Trigger.OperationType {
        when BEFORE_INSERT {
            
            CompraService.compraTriggerHandlerCalculaValorTotal(Trigger.new);
            CompraService.compraTriggerHandlerValidaQuantidade(Trigger.new);
        }
        when BEFORE_UPDATE{

            CompraService.reduzirProdutosDoEstoque(Trigger.new);
            CompraService.compraTriggerHandlerCalculaValorTotal(Trigger.new);
            CompraService.compraTriggerHandlerValidaQuantidade(Trigger.new);
        }
        when AFTER_INSERT{

	            CompraService.reduzirProdutosDoEstoque(Trigger.new);

}
        
    }

}