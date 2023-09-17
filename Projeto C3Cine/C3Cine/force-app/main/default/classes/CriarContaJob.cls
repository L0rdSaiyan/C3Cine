public with sharing class CriarContaJob implements Schedulable {
    public void execute(SchedulableContext ctx) {
        // Crie uma nova conta chamada "Victor"
        Account novaConta = new Account();
        novaConta.Name = 'Victor Schedulable 1 hora dps';

        // Insira a conta no Salesforce
            insert novaConta;
            System.debug('Conta "Victor" criada com sucesso.');
           
        }
    
}