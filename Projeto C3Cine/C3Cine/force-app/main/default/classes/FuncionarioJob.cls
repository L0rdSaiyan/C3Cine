public with sharing class FuncionarioJob implements Schedulable {
    public void execute(SchedulableContext ctx) {

        FuncionariosService.resetarRankDeTodosOsFuncionariosMensalmente();

    }
    // System.schedule('MeuTrabalhoAgendado', '0 0 0 1 * ?', new TesteApexSchedule());



}