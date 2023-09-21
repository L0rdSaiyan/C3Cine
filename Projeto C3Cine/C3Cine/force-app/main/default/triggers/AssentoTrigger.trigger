trigger AssentoTrigger on Assento__c (before insert, after insert) {

    switch on Trigger.OperationType {
        when BEFORE_INSERT {
            AssentoService.inserirValorAssento(Trigger.new);
            AssentoService.atribuirSalaAoAssento(Trigger.new);
        }
       
        when AFTER_INSERT{

            AssentoService.atribuirAssentoAoIngresso(Trigger.new);
            

        }

    }


}