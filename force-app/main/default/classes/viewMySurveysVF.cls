public class viewMySurveysVF {
    
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