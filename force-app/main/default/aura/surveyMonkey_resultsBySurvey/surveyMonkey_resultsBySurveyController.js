({
	doInit: function(component, event, helper) {
		var action = component.get('c.getSurveysByTemplate');
		var userId = $A.get("$SObjectType.CurrentUser.Id");
		action.setParams({
            'userId': userId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {//update to new data structure
				var surveys = response.getReturnValue();
				console.log(surveys);
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
		component.set('v.productReviewIsOpen', !component.get('v.productReviewIsOpen'));
	}
})