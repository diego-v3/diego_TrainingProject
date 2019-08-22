public class viewMySurveysVF {
    public String namespace { get; set; }

    public viewMySurveysVF() {
        namespace = constants.NAMESPACE;
    }

    public String getNamespaceApi() {
        return constants.NAMESPACE_API;
    }
    
   	@AuraEnabled
    public static String getData(String userId) {
        responseData rd = new responseData();
        
        try {
            rd.put('userId', userId);
            //List<SObject> data = Database.query('SELECT Id, Name FROM ' + constants.NAMESPACE_API + 'Survey__c');
            List<SObject> data = Database.query('SELECT Name, ' + constants.NAMESPACE_API + 'Date_Created__c, (SELECT Name, ' + constants.NAMESPACE_API + 'Question__r.Name FROM ' + constants.NAMESPACE_API + 'Selected_Answers__r) FROM ' + constants.NAMESPACE_API + 'Taken_Survey__c ORDER BY ' + constants.NAMESPACE_API + 'Date_Created__c DESC');
            //List<SObject> data = Database.query('SELECT Name, ' + constants.NAMESPACE_API + 'Date_Created__c, (SELECT Name, ' + constants.NAMESPACE_API + 'Question__r.Name FROM ' + constants.NAMESPACE_API + 'Selected_Answers__r) FROM ' + constants.NAMESPACE_API + 'Taken_Survey__c WHERE CreatedById = ' + userId + ' ORDER BY ' + constants.NAMESPACE_API + 'Date_Created__c DESC');
            if (data.isEmpty()) {
                System.debug('got no data');
            } else {
                rd.put('data', data);
            }
        } catch(Exception e) {
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }
    
    @AuraEnabled
    public static List<Taken_Survey__c> getMyTakenSurveys(String userId) {
        return [SELECT Name, Date_Created__c, 
                (
                    SELECT Name, Question__r.Name FROM Selected_Answers__r
                )
                FROM Taken_Survey__c
                WHERE CreatedById = :userId
                ORDER BY Date_Created__c DESC];         
    }

    @AuraEnabled
    public static List<Taken_Survey__c> getSurveysByTemplate() {
        return [SELECT Name, Date_Created__c, CreatedById
                FROM Taken_Survey__c
                ORDER BY Date_Created__c DESC];           
    }
}