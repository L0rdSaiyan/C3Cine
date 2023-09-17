public with sharing class TesteCriarRegistroJobSchedule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        // Crie aqui o registro desejado
        Account novoRegistro = new Account();
        novoRegistro.Name = 'Victor Schedulable'; // Atribua o valor ao campo Name diretamente
        // Defina outros campos conforme necessário
        insert novoRegistro;
    }
}