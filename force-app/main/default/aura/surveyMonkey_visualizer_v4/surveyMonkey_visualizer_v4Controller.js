({
	doInit: function(component, event, helper) {
		var action = component.get('c.getData');
		var userId = $A.get("$SObjectType.CurrentUser.Id");
		action.setParams({
            'userId': userId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
				//var surveys = response.getReturnValue();
				var parsedRes = JSON.parse(response.getReturnValue());//new
                var surveys = parsedRes.results.data;//new
				for(var i=0; i<surveys.length; i++) {
					surveys[i].expanded = false;
                    //surveys[i].answers = surveys[i].selectedAnswers.records;
				}
				component.set('v.surveys', surveys);
                debugger
            }
        });
        $A.enqueueAction(action);
	},
	
	customerSurveyButtonClick : function(component, event, helper) {
		var target = event.target;
		var index = target.getAttribute("id");
		component.set('v.surveys['+index+'].expanded', !component.get('v.surveys['+index+'].expanded'));
	},

    productReviewButtonClick : function(component, event, helper) {
		var toggledElement = event.target.id;
		component.set('v.productReviewIsOpen', !component.get('v.productReviewIsOpen'));
	}
})