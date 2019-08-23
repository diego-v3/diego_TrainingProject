public class viewMySurveysVF {
   	@AuraEnabled
    public static String getData(String userId) {
        responseData rd = new responseData();
        
        try {
            rd.put('userId', userId);
            List<SObject> data = Database.query('SELECT Name, ' + constants.NAMESPACE_API + 'Date_Created__c, (SELECT Name, ' + constants.NAMESPACE_API + 'Question__r.Name FROM ' + constants.NAMESPACE_API + 'Selected_Answers__r) FROM ' + constants.NAMESPACE_API + 'Taken_Survey__c WHERE CreatedById = \'' + userId + '\' ORDER BY ' + constants.NAMESPACE_API + 'Date_Created__c DESC');
            if (data.isEmpty()) {
                System.debug('got no data');
            } else {
                rd.put('data', data);
            }
        } catch(Exception e) {
            System.debug(e);
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }

    @AuraEnabled
    public static String getSurveysByTemplate() {
        responseData rd = new responseData();
        try {
            List<SObject> data = Database.query('SELECT Name, ' + constants.NAMESPACE_API + 'Date_Created__c, CreatedById FROM ' + constants.NAMESPACE_API + 'Taken_Survey__c ORDER BY ' + constants.NAMESPACE_API + 'Date_Created__c DESC');
            if (data.isEmpty()) {
                System.debug('got no data getSurveysByTemplate');
            } else {
                rd.put('data', data);
            }
        } catch(Exception e) {
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();       
    }
}