public with sharing class takeSurvey {

    //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static String serverEcho(String firstName) {
        return ('Hello from the server, ' + firstName);
    }

    @AuraEnabled
    public static Map<String, Object> getInitialData(String surveyId) {
        Map<String, Object> data = new Map<String, Object>();

        List<Question__c> questions = [SELECT Name, id, Order_Number__c, Survey__r.Name,
                                       ( SELECT Name, id, Order_Number__c FROM Answers__r ORDER BY Order_Number__c ASC)
                                       FROM Question__c 
                                       WHERE Survey__c = :surveyId
                                       ORDER BY Order_Number__c ASC];


        data.put('questions', questions);
        data.put('surveyName', questions[0].Survey__r.Name);

        return data;
    }
}

