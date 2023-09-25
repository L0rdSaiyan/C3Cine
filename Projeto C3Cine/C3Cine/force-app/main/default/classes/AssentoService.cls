public with sharing class AssentoService {

    // Método para inserir o valor do assento (Valor_do_Assento__c) com base no ingresso relacionado (Ingresso__c).
    public static void inserirValorAssento(List<Assento__c> assentos) {

        List<Id> ingressos = new List<Id>();

        // Extrai IDs dos ingressos a partir da lista de assentos.
        for (Assento__c assento : assentos) {
            ingressos.add(assento.Ingresso__c);
        }

        // Consulta os ingressos relacionados para obter seus valores e atribui aos assentos.
        List<Ingressos__c> ingressosRelacionados = [
            SELECT Id, Name, Valor_do_Ingresso__c 
            FROM Ingressos__c 
            WHERE Id IN :ingressos
        ];

        for (Ingressos__c ingresso : ingressosRelacionados) {
            for (Assento__c assento : assentos) {
                assento.Valor_do_Assento__c = ingresso.Valor_do_Ingresso__c;
            }
        }
    }

    // Método para atribuir um assento (Assento__c) a um ingresso relacionado (Ingresso__c).
    public static void atribuirAssentoAoIngresso(List<Assento__c> assentos) {

        List<Id> ingressosId = new List<Id>();

        // Extrai IDs dos ingressos a partir da lista de assentos.
        for (Assento__c assento : assentos) {
            ingressosId.add(assento.Ingresso__c);
        }

        // Consulta os ingressos relacionados e atribui os assentos a eles.
        List<Ingressos__c> ingressos = [
            SELECT Id, Name, Assento__c
            FROM Ingressos__c
            WHERE Id IN :ingressosId
        ];

        for (Ingressos__c ingresso : ingressos) {
            for (Assento__c assento : assentos) {
                ingresso.Assento__c = assento.Id;
            }
        }

        // Atualiza os ingressos relacionados com os assentos atribuídos.
        update ingressos;
    }

    // Método para atribuir uma sala (Sala__c) a um assento (Assento__c).
    public static void atribuirSalaAoAssento(List<Assento__c> assentos) {

        List<Id> ingressosId = new List<Id>();

        // Extrai IDs dos ingressos a partir da lista de assentos.
        for (Assento__c assento : assentos) {
            ingressosId.add(assento.Ingresso__c);
        }

        // Consulta os ingressos relacionados para obter a sala e atribui aos assentos.
        List<Ingressos__c> ingressos = [
            SELECT Id, Name, Sala__c
            FROM Ingressos__c
            WHERE Id IN :ingressosId
        ];

        for (Assento__c assento : assentos) {
            for (Ingressos__c ingresso : ingressos) {
                assento.Sala__c = ingresso.Sala__c;
            }
        }
    }
}