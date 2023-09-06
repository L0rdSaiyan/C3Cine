public with sharing class IngressoService {

    public static void ingressoTriggerHandlerBeforeInsert(List<Ingressos__c> ingressos) {

        List<Id> funcionariosToUpdate = new List<Id>();

        for (Ingressos__c ingresso : ingressos) {

            if (ingresso.Funcionario_que_vendeu_o_ingresso__c != null) {
                funcionariosToUpdate.add(ingresso.Funcionario_que_vendeu_o_ingresso__c);
            }
        }

        if (!funcionariosToUpdate.isEmpty()) {

            List<Funcionario__c> funcionarios = [SELECT Id, Name, Ingressos_Vendidos__c 
                                                  FROM Funcionario__c
                                                  WHERE Id IN :funcionariosToUpdate];

            for (Funcionario__c funcionario : funcionarios) {
                if (funcionario.Ingressos_Vendidos__c == null) {
                    funcionario.Ingressos_Vendidos__c = 1;
                } else {
                    funcionario.Ingressos_Vendidos__c += 1;
                }
            }

            update funcionarios;
        }
    }
}