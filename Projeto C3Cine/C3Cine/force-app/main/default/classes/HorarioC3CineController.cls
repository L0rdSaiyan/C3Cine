public with sharing class HorarioC3CineController {
  
    @AuraEnabled
public static Boolean retornarHorarioFuncionamento(){

    Integer currentHour = Datetime.now().hour();
    Boolean funcionando;
    if(currentHour>=9 && currentHour <=23){
        funcionando=true;
    }else{
        funcionando=false;
    }

return funcionando;

}

}