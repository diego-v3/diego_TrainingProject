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
                var parsedRes = JSON.parse(response.getReturnValue());
                var survey = parsedRes.results.data;
                survey.name=parsedRes.results.surveyName.Name;
                debugger
                component.set('v.survey', survey);
            }
        });
        $A.enqueueAction(action);
    },

    submit: function(component, event, helper) {
        var action = component.get('c.insertRecords');
        action.setParams({
            'survey': component.get('v.survey')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                document.location.reload(true);
            } else {
                
            }
        });
        $A.enqueueAction(action); 
    }
})
