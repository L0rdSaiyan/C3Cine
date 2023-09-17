public with sharing class AgendarJob {
    public void agendarJobSemanal() {
        // Especifique o horário e dia da semana para a execução do job
        // No exemplo abaixo, o job será executado toda segunda-feira às 21:05
        String cronExpression = '0 25 21 ? * MON'; 

        // Nome do job agendado
        String jobName = 'MeuJobSemanal';

        // Crie uma instância da classe que implementa o job Schedulable
        TesteApexSchedule meuJob = new TesteApexSchedule();

        // Agende o job
        System.schedule(jobName, cronExpression, meuJob);
    }
}