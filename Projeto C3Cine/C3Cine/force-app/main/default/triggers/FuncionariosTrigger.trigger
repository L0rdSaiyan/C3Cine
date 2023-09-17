trigger FuncionariosTrigger on Funcionario__c (before insert, before update) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
            FuncionariosService.funcionarioTriggerHandlerRank(Trigger.new);
            FuncionariosService.validarNumeroDeIngressosTriggerHandler(Trigger.new);
            FuncionariosService.incrementarTotalDeIngressosVendidosTriggerHandler(Trigger.new);

        }
        when BEFORE_UPDATE{

            FuncionariosService.funcionarioTriggerHandlerRank(Trigger.new);
            FuncionariosService.validarNumeroDeIngressosTriggerHandler(Trigger.new);
            FuncionariosService.incrementarTotalDeIngressosVendidosTriggerHandler(Trigger.new);
            FuncionariosService.aumentarVezesFuncionarioDaSemanaTriggerHandler(Trigger.new, Trigger.oldMap);
            
        }
    }
}