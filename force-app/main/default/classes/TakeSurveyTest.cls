@isTest
private class TakeSurveyTest {
     @isTest static void testGetInitialData() {
        //var surveyId = '0054F000001PYnuQAG';
        Survey__c testSurvey = new Survey__c(Name='Who will win next election?');
        Test.startTest();
        insert testSurvey;
        ID testId = testSurvey.id;
        Question__c testQuestion = new Question__c(Name='Will it be you?', Survey__c=testSurvey.id);
        insert testQuestion;
        Answer__c testAnswer = new Answer__c(Name='The answer is yes.', Question__c=testQuestion.id);
        insert testAnswer;
        Test.stopTest();
        Map<String, Object> surveyDataMap = takeSurvey.getInitialData(testId);
        System.assertEquals(surveyDataMap.get('name'), 'Who will win next election?');
        System.assertEquals(surveyDataMap.get('id'), testId);
        List<Object> questionsRetrieved = (List<Object>)surveyDataMap.get('questions');
        Map<String, Object> quest = (Map<String, Object>)questionsRetrieved.get(0);
        System.assertEquals(quest.get('name'), 'Will it be you?');
        //---
    }
    @isTest static void testInsertRecords() {
        Map<String, Object> testSurveyMap = new Map<String, Object>();
        String surveyName = 'Who should you vote for?';
        Survey__c testSurvey = new Survey__c(Name=surveyName);
        Test.startTest();
        insert testSurvey;
        testSurveyMap.put('name',surveyName);
        testSurveyMap.put('id', testSurvey.id);
        Taken_Survey__c testTakenSurvey = new Taken_Survey__c(Name='Who should you vote for?', Survey__c=testSurvey.id);
        insert testTakenSurvey;
        Question__c testQuestion = new Question__c(Name='Are you a good person?', Survey__c=testSurvey.id);
        insert testQuestion;
        Answer__c testAnswer = new Answer__c(Name='No', Question__c=testQuestion.id);
        Map<Object, Object> testQuestionMap = new Map<Object, Object>();
        List<Map<Object, Object>> testQuestions = new List<Map<Object, Object>>();
        List<Object> testAnswers = new List<Object>();
        Map<Object, Object> testAnswerMap = new  Map<Object, Object>();
        testAnswerMap.put('id', testAnswer.id);
        testAnswerMap.put('name', testAnswer.name);
        testAnswerMap.put('selected', true);
        testAnswers.add(testAnswerMap);
        testQuestionMap.put('id', testQuestion.id);
        testQuestionMap.put('answers', testAnswers);
        testQuestions.add(testQuestionMap);
        testSurveyMap.put('questions', testQuestions);
        takeSurvey.insertRecords(testSurveyMap);

        System.assertEquals(testSurveyMap.get('id'), testSurvey.id);

        //var surveyId = '0054F000001PYnuQAG'
    }
    
}