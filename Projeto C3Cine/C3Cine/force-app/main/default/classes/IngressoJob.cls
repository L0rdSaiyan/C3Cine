public with sharing class IngressoJob implements Schedulable  {
    public void execute(SchedulableContext ctx) {

    IngressoService.apagarIngressosAntigosFlow();

    }
}

//System.schedule('IngressoJob', '0 0 ? * 2', new TesteApexSchedule()); = semanalmente toda segunda
//System.schedule('IngressoJob', '0 10 * * * ?', new TesteApexSchedule()); = 10 minutos
