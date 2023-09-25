public with sharing class FilmesSelector {
   
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

}