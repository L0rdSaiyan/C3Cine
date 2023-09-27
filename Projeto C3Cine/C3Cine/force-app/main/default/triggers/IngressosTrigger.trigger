trigger IngressosTrigger on ingressos__c (before insert, before delete, after delete) {

    switch on Trigger.OperationType {
        when BEFORE_INSERT {
    
                IngressoService.valdidarCampoAssento(Trigger.new);
                IngressoService.ingressoTriggerHandlerBeforeInsert(Trigger.new);
                IngressoService.ingressoTriggerHandlerValidarFilme(Trigger.new);
                IngressoService.reduzirAssentosDeSala(Trigger.new);
                IngressoService.validarValorDoIngresso(Trigger.new);
                IngressoService.validarQuantidadeAssentos(Trigger.new);
                IngressoService.validarFuncionarioPIngresso(Trigger.new);
    }
        when BEFORE_DELETE{
            IngressoService.aumentarAssentosDisponiveisTriggerHandlerBeforeDelete(Trigger.old);
        }
        when AFTER_DELETE{
	            IngressoService.deleterReversaDeAssento(Trigger.old);
}
    
    }
    
    }