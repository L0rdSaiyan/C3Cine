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

    public static List<Ingressos__c> consultarIngressosAntigos() {
        List<Ingressos__c> ingressosAntigos = [SELECT Id, Name, CreatedDate
                                                FROM Ingressos__c
                                                WHERE CreatedDate < :Date.today().addDays(-7)];
        return ingressosAntigos;
    }
    

   public static List<Cliente__c> consultarClientes(List<Id> clientesId ){

    list<Cliente__c> clientes = [SELECT Name, Id, Apresentou_Carteirinha__c, Pessoa_com_DeficiEncia_PCD__c, estudante__c
                               FROM Cliente__c 
                               WHERE Id IN :clientesId]; 

    return clientes;

   }


   public static List<Funcionario__c> selecionarFuncionario(List<Id> funcionariosToUpdate){

    List<Funcionario__c> funcionarios = [SELECT Id, Name, Ingressos_Vendidos__c, CPF__c, Email__c, Cargo__c
    FROM Funcionario__c
    WHERE Id IN :funcionariosToUpdate];

    return funcionarios;


   }

   public static List<Sala__c> selecionarSalas(List<Id> salasToSelect){

    List<Sala__c> salas = [SELECT Name, Id, Quantidade_de_Assentos__c
                          FROM Sala__c
                          WHERE Id IN: salasToSelect];

    return salas;

   }

}