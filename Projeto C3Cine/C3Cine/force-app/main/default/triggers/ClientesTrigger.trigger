trigger ClientesTrigger on Cliente__c (before insert, before update) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {

        }
       
    }


}