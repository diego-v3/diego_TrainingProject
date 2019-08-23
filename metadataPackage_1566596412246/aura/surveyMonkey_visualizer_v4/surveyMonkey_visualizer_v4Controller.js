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
				var parsedRes = JSON.parse(response.getReturnValue());
                var surveys = parsedRes.results.data;
				for(var i=0; i<surveys.length; i++) {
					surveys[i].expanded = false;
				}
				component.set('v.surveys', surveys);
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