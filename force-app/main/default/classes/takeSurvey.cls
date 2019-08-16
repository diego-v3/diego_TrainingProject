public with sharing class takeSurvey {

    @AuraEnabled
    public static Map<String, Object> getInitialData(ID surveyId) {
        Map<String, Object> surveyMap = new Map<String, Object>();
        surveyMap.put('id', [SELECT Id, Name FROM Survey__c WHERE Id =:surveyId].Id);
        surveyMap.put('name', [SELECT Id, Name FROM Survey__c WHERE Id =:surveyId].Name);

        List<Question__c> records = [SELECT Id, Name, Order_Number__c, Survey__r.Name,
                                        ( 
                                           SELECT Id, Name, Order_Number__c 
                                           FROM Answers__r 
                                           ORDER BY Order_Number__c ASC
                                        )
                                       FROM Question__c 
                                       WHERE Survey__c = :surveyId
                                       ORDER BY Order_Number__c ASC];

        List<Object> questions = new List<Object>();
        for(Question__c record : records) {
            Map<String, Object> questionMap = new Map<String, Object>();
            questionMap.put('id', record.Id);
            questionMap.put('name', record.Name);
            questionMap.put('orderNumber', record.Order_Number__c);

            List<Object> answers = new List<Object>();
            for(Answer__c answer : record.Answers__r) {
                Map<String, Object> answerMap = new Map<String, Object>();
                answerMap.put('id', answer.Id);
                answerMap.put('name', answer.Name);
                answerMap.put('orderNumber', answer.Order_Number__c);
                answerMap.put('selected', false);
                answers.add(answerMap);
            }
            questionMap.put('answers', answers);
            questions.add(questionMap);
        }
        surveyMap.put('questions', questions);

        return surveyMap;
    }

    @AuraEnabled
    public static void insertRecords(Map<String, Object> survey) {
        Taken_Survey__c takenSurvey = new Taken_Survey__c (
            Name = (String)survey.get('name'),
            Survey__c = (String)survey.get('id')
        );
        insert takenSurvey;

       
        List<Selected_Answer__c> selectedAnswers = new List<Selected_Answer__c>();
        List<Object> questions = (List<Object>)survey.get('questions');
        for(Object question : questions) {
            Map<Object, Object> questionMap = (Map<Object, Object>)question;
            List<Object> answers = (List<Object>)questionMap.get('answers');
            for(Object answer : answers) {
                Map<Object, Object> answerMap = (Map<Object, Object>)answer;
                if((Boolean)answerMap.get('selected')) {
                    Selected_Answer__c selectedAnswer = new Selected_Answer__c (
                        Taken_Survey__c = (String)takenSurvey.Id,
                        Question__c = (String)questionMap.get('id'),
                        Answer__c = (String)answerMap.get('id'),
                        Name = (String)answerMap.get('name')
                    );
                    selectedAnswers.add(selectedAnswer);
                }         
            }
        }
        insert selectedAnswers;

    }
}