trigger SalasTrigger on Sala__c (before insert, before update) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            
            SalasService.aplicarAssentosPadraoParaSalaTriggerHandler(Trigger.new);
            SalasService.definirdisponibilidadeDaSalaTriggerHandler(Trigger.new);
        }
        when BEFORE_UPDATE{
            SalasService.definirdisponibilidadeDaSalaTriggerHandler(Trigger.new);

        }
        
    }

    


}