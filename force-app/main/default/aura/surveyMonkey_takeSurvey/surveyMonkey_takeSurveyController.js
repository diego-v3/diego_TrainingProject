({
	customerSurveyButtonClick : function(component, event, helper) {
		component.set('v.customerSurveyIsOpen', !component.get('v.customerSurveyIsOpen'));
	},
    productReviewButtonClick : function(component, event, helper) {
		component.set('v.productReviewIsOpen', !component.get('v.productReviewIsOpen'));
	},
	populateSurvey : function(component, event, helper) {
//		Survey[] sur = new [SELECT Name FROM Question__c]
	}
})