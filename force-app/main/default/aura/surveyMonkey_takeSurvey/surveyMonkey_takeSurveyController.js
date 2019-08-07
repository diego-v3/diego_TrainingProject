({
    doInit: function(component, event, helper) {
        var surveyId = component.get('v.surveyId');

        var action = component.get('c.getInitialData');
        action.setParams({
            'surveyId': surveyId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                var data = response.getReturnValue();
                var surveyName = data.surveyName;
                var questions = data.questions;

                component.set('v.surveyName', surveyName);
                component.set('v.questions', questions);
                //component.set('v.sObjList', a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    submit: function(component, event, helper) {
        var surveyId = component.get('v.surveyId');
        var action = component.get('c.prepareSubmission');
        action.setParams({
            'surveyId': surveyId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                var answers = response.getReturnValue();

                //component.set('v.answerList', answers);
                helper.checkAnswers(answers);
            }
        });
        $A.enqueueAction(action);
    }

})
