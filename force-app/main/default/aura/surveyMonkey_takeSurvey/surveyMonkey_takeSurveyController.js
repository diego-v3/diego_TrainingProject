({
    doInit: function(component, event, helper) {
        var surveyId = component.get('v.surveyId');

        var action = component.get('c.getInitialData');
        action.setParams({
            'surveyId': surveyId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {//update to new data structure
                var survey = response.getReturnValue();
                debugger
                component.set('v.survey', survey);
            }
        });
        $A.enqueueAction(action);
    },

    submit: function(component, event, helper) {
        debugger

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
