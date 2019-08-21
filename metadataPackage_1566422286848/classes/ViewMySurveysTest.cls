@isTest
private class ViewMySurveysTest {
     @isTest static void testGetMyTakenSurveys() {
        date mydate = date.parse('12/27/2009');
        Survey__c testSurvey = new Survey__c(Name='Survey Template for testing');
        Taken_Survey__c testTakenSurvey = new Taken_Survey__c(Name='Test Survey 01', Date_Created__c=mydate);
        Test.startTest();
        insert testSurvey;
        insert testTakenSurvey;
        Question__c testQuestion = new Question__c(Name='Did you do it?', Survey__c=testSurvey.id);
        insert testQuestion;
        Selected_Answer__c testAnswer = new Selected_Answer__c(Name='The answer is yes.', Question__c=testQuestion.id);
        insert testAnswer;
        Test.stopTest();
        List<Taken_Survey__c> surveyData = viewMySurveysVF.getMyTakenSurveys('0054F000001PYnuQAG');
        List<Taken_Survey__c> testList = new List<Taken_Survey__c>();
        testList.add(testTakenSurvey);
        System.assertEquals(surveyData, testList);
    }

    @isTest static void testGetSurveysByTemplate() {
        date mydate = date.parse('12/27/2009');
        Taken_Survey__c testTakenSurvey = new Taken_Survey__c(Name='Test Survey 02', Date_Created__c=mydate);
        Test.startTest();
        insert testTakenSurvey;
        Test.stopTest();
        List<Taken_Survey__c> surveyData = viewMySurveysVF.getSurveysByTemplate();
        List<Taken_Survey__c> testList = new List<Taken_Survey__c>();
        testList.add(testTakenSurvey);
        System.assertEquals(surveyData[0].Name, testList[0].Name);
        System.assertEquals(surveyData[0].Name, testList[0].Name);
    }
    
}