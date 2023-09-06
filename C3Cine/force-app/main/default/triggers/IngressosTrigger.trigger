trigger IngressosTrigger on ingressos__c (before insert) {

switch on Trigger.OperationType {
    when BEFORE_INSERT {

            IngressoService.ingressoTriggerHandlerBeforeInsert(Trigger.new);
            
}
}

}