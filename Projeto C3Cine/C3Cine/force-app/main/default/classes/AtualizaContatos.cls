public with sharing class AtualizaContatos {
   

public class Retorno{

    String trailhead;


}

public class Endereco{

    String cep;
    String logradouro;
    String complemento;
    String bairro;
    String localidade;
    String uf;
    String ibge;
    String gia;
    String ddd;
    String siafi;


}

    @future(callout=true)
    public static void buscarCep(){

        Http h = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://viacep.com.br/ws/01001000/json/');
        req.setMethod('GET');

        HttpResponse res = h.send(req);

        Endereco resposta = (Endereco)JSON.deserialize(res.getBody(), Endereco.class);
        System.debug('o retorno foi: '+resposta.logradouro);

    }


    @future(callout=true) //deve ser estático e void e só pode receber como parametro tipos primitivos                             //O callout serve para indicar que ele vai acessar um serviço externo
    public static void buscarSite(){

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com');
        req.setMethod('GET');

        HttpResponse res = h.send(req);


        Retorno resposta = (Retorno)JSON.deserialize(res.getBody(), Retorno.class);
        System.debug('O retorno foi: '+resposta);
        

    }

}