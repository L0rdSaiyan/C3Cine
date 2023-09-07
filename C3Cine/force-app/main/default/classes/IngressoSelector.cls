public with sharing class IngressoSelector {

    public static List<Filme__c> consultarFilmePorId(List<Id> filmesToUpdate) {

        List<Filme__c> resultados = new List<Filme__c>();

        if (filmesToUpdate != null && !filmesToUpdate.isEmpty()) {
            String consulta = 'SELECT Name, Id, A_produta_renovou_o_contrato__c, Esta_em_Cartaz__c ' +
                             'FROM Filme__c ' +
                             'WHERE Id IN :filmesToUpdate';

            resultados = Database.query(consulta);
        }

        return resultados;
    }

    public static List<Ingressos__c> consultarIngressosAntigos(){

        List<Ingressos__c> ingressosAntigos = [SELECT Id, Name, CreatedDate
        FROM Ingressos__c
        WHERE CreatedDate > :Date.today().addDays(7)];

        return ingressosAntigos;

    }

}
