trigger FuncionariosTrigger on Funcionario__c (before insert) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
            // Use o nome correto da classe: FuncionariosService
            FuncionariosService.funcionarioTriggerHandlerBeforeInsertRank(Trigger.new);
            FuncionariosService.validarNumeroDeIngressosTriggerHandler(Trigger.new);
        }
    }
}
