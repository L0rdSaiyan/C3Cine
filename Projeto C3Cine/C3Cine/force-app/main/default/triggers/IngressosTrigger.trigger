trigger IngressosTrigger on ingressos__c (before insert, before delete) {

switch on Trigger.OperationType {
    when BEFORE_INSERT {

            IngressoService.ingressoTriggerHandlerBeforeInsert(Trigger.new);
            IngressoService.ingressoTriggerHandlerValidarFilme(Trigger.new);
            IngressoService.reduzirAssentosDeSala(Trigger.new);
            IngressoService.validarValorDoIngresso(Trigger.new);
            IngressoService.validarQuantidadeAssentos(Trigger.new);

        
}
    when BEFORE_DELETE{


        IngressoService.aumentarAssentosDisponiveisTriggerHandlerBeforeDelete(Trigger.old);

    }


}

}