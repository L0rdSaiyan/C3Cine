global with sharing class ProductorName {
 @AuraEnabled
    public static List<String> getProductNames() {
        List<String> productNames = new List<String>();
		
        List<Produtos__c> products = [SELECT Id, Name FROM Produtos__c];
		for (Produtos__c product : products) {
            productNames.add(product.Name);
        }
        
        return productNames;
    }

    
}