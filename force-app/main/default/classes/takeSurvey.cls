public with sharing class takeSurvey {

    //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static String serverEcho(String firstName) {
        return ('Hello from the server, ' + firstName);
    }

    @AuraEnabled
    public static Map<String, Object> getInitialData(String surveyId) {
        Map<String, Object> surveyMap = new Map<String, Object>();
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
                answerMap.put('selected', true);
                answers.add(answerMap);
            }
            questionMap.put('answers', answers);
            questions.add(questionMap);
        }
        surveyMap.put('questions', questions);



        // ITERIATE OVER QUESTIONS
        // ITERATE OVER QUESTION ANSWERS
        // BUILD AN ANSWER MAP, SET PROPERTY selected TO FALSE
        // PUT THEM IN answers LIST
        // BUIILD A QUESTION MAP
        // PUT THEM IN questions LIST
        // ADD questions TO data MAP
        
        //  {
        //         surveyName: 'A',
        //         questions: [
        //             {
        //                 answers: [
        //                     {
        //                         selected: false
        //                     }
        //                 ]
        //             }
        //         ]
        //  }
        
        // List<Map<String, List<Map<String, Object>>>> questionList = new List<Map<String, List<Map<String, Object>>>>();
        // Map<String, List<Map<String, Object>>> questionMap = new Map<String, List<Map<String, Object>>>();
        // for(Question__c question : questions) {
        //     List<Map<String, Object>> answers = new List<Map<String, Object>>();
        //     for(Answer__c answer : question.Answers__r){
        //         Map<String, Object> answerMap = new Map<String, Object>();
        //         answerMap.put('name', answer.Name);
        //         answerMap.put('id', answer.id);
        //         answerMap.put('orderNumber', answer.Order_Number__c);
        //         answerMap.put('selected', false);
        //         //answerMap.put('surveyName', answer.Question__c.name);
        //         answers.add(answerMap);
        //     }
        //     questionMap.put(question.Name, answers);
            
        // }   
        // questionList.add(questionMap);

        return surveyMap;
    }

    @AuraEnabled
    public static List<Answer__c> prepareSubmission(String surveyId) {//optimize to just a list, no need to use map

        List<Answer__c> answerIds = [SELECT Name, id, Question__c
                                        FROM Answer__c
                                        WHERE Question__r.Survey__c = :surveyId 
                                        ORDER BY Question__c];

        return answerIds;
    }
}