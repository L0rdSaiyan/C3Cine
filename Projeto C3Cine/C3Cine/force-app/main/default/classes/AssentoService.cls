public with sharing class AssentoService {

    public static void inserirValorAssento(List<Assento__c> assentos){

        List<Id> ingressos = new List<Id>();

        for(Assento__c assento : assentos){

    ingressos.add(assento.Ingresso__c);

        }

        List<ingressos__c> ingressosRelacionados = [SELECT Id, Name, Valor_do_Ingresso__c 
                                                    FROM ingressos__c WHERE Id IN:ingressos];

         for(ingressos__c ingresso : ingressosRelacionados){

    for(Assento__c assento : assentos){

        assento.Valor_do_Assento__c = ingresso.Valor_do_Ingresso__c;

    }

         }                                           

    }


    

    public static void updateMemeHandler(List<Assento__c> assentos){

        List<Id> ingressosId = new List<Id>();

        for(Assento__c assento : assentos){

            ingressosId.add(assento.Ingresso__c);
        }

        List<Ingressos__c> ingressos = [SELECT Id, Name, Assento__c
                                        FROM Ingressos__c
                                          WHERE Id IN : ingressosId  ];

        for(Ingressos__c ingresso : ingressos){

            for(Assento__c assento : assentos){

                ingresso.Assento__c = assento.Id;

            }

        }

        update ingressos;

    }

}


