public with sharing class FuncionariosService {
  
    public static void funcionarioTriggerHandlerRank(List<Funcionario__c> funcionarios){

        for(Funcionario__c funcionario : funcionarios){
           if(funcionario.Ingressos_Vendidos__c >=0 && funcionario.Ingressos_Vendidos__c<=9 ){
            funcionario.Ranks__c = 'Iniciante';
           }else if(funcionario.Ingressos_Vendidos__c >= 10 && funcionario.Ingressos_Vendidos__c <= 19){
                funcionario.Ranks__c = 'Competente';
            } else if(funcionario.Ingressos_Vendidos__c >= 20 && funcionario.Ingressos_Vendidos__c <= 29){
                funcionario.Ranks__c = 'Experiente';
            } else if(funcionario.Ingressos_Vendidos__c >= 30 && funcionario.Ingressos_Vendidos__c <= 39){
                funcionario.Ranks__c = 'C3Ceiro';
            } else if(funcionario.Ingressos_Vendidos__c >= 40 && funcionario.Ingressos_Vendidos__c <= 49){
                funcionario.Ranks__c = 'Líder de Equipe';
            } else if(funcionario.Ingressos_Vendidos__c >=50){
                funcionario.Ranks__c = 'Funcionário do Mês';

            }
        }

    }

    public static void validarNumeroDeIngressosTriggerHandler(List<Funcionario__c> funcionarios){

        for(Funcionario__c funcionario : funcionarios){
            if(funcionario.Ingressos_Vendidos__c < 0){
                funcionario.Ingressos_Vendidos__c.addError('Valores negativos não são permitidos!');
            }
        }
    }


    public static void incrementarTotalDeIngressosVendidosTriggerHandler(List<Funcionario__c> funcionarios){
        for(Funcionario__c funcionario : funcionarios){
            if (funcionario.Total_de_ingressos_vendidos__c != null && funcionario.Ingressos_Vendidos__c != null) {
                funcionario.Total_de_ingressos_vendidos__c += funcionario.Ingressos_Vendidos__c;
            }
            else if(funcionario.Ingressos_Vendidos__c == null ){

                funcionario.Ingressos_Vendidos__c = 0;

            }else if(funcionario.Total_de_ingressos_vendidos__c == null){
    
                funcionario.Total_de_ingressos_vendidos__c = 0;
                funcionario.Total_de_ingressos_vendidos__c += funcionario.Ingressos_Vendidos__c;
    
            }
        }
    }
    
        public static void aumentarVezesFuncionarioDaSemanaTriggerHandler(List<Funcionario__c> novosRegistros, Map<Id, Funcionario__c> registrosAntigos) {
            for (Funcionario__c novoRegistro : novosRegistros) {
                Funcionario__c registroAntigo = registrosAntigos.get(novoRegistro.Id);
    
                if (registroAntigo != null) {
                    if (novoRegistro.Ranks__c != registroAntigo.Ranks__c) {
                        if (novoRegistro.Ranks__c == 'Funcionário do Mês') {
                            if (novoRegistro.N_vezes_funcionario_do_mes__c == null) {
                                novoRegistro.N_vezes_funcionario_do_mes__c = 1;
                            } else {
                                novoRegistro.N_vezes_funcionario_do_mes__c += 1;
                            }
                        }
                    }
                }
            }
        
    }
    

    @invocableMethod(Label='Reseta o rank de todos os funcionários da org Mensalmente')
public static void resetarRankDeTodosOsFuncionariosMensalmente() {
    List<Funcionario__c> funcionarios = FuncionarioSelector.selecionarTodosOsFuncionarios();

        for(Funcionario__c funcionario : funcionarios){
            funcionario.Ingressos_Vendidos__c = 0;
        }

        update funcionarios;

}


public static void validarCargoParaVenderIngressos(List<Funcionario__c> funcionarios ){

    for(Funcionario__c funcionario : funcionarios){

        if(funcionario.Cargo__c != 'Caixa de Cinema' && funcionario.Ingressos_Vendidos__c != null && funcionario.Total_de_ingressos_vendidos__c	!= null){

            funcionario.Cargo__c.addError('Você pode atribuir ingressos vendidos para um funcionário q n é da bilheteria');

        }

    }


}
    


}