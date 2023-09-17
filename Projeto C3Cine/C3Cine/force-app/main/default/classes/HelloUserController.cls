public class HelloUserController {

  @AuraEnabled
  public static String greetings() {
      String user = UserInfo.getName(); // Variável que recebe o nome do usuário atual do sistema
      return user;
  }

  @AuraEnabled
  public static String getTime() {
      Integer currentHour = Datetime.now().hour();
      String saudacao;

      if (currentHour >= 0 && currentHour <= 6) {
          saudacao = 'Boa Madrugada ';
      } else if (currentHour > 6 && currentHour <= 12) {
          saudacao = 'Bom Dia ';
      } else if (currentHour > 12 && currentHour <= 18) {
          saudacao = 'Boa Tarde! ';
      } else if (currentHour > 18 && currentHour <= 24) {
          saudacao = 'Boa Noite ';
      }

      return saudacao;
  }
}