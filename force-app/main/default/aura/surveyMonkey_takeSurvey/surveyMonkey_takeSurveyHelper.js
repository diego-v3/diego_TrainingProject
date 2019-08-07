({
	checkAnswers : function(answers) {
		var formattedAnswers = [];
		console.log(answers);
        answers.forEach(function(answer) {//i could do the binding like -> https://developer.salesforce.com/docs/component-library/bundle/ui:inputCheckbox/example
			var id = answer.id;
			//check if that id has been checked 
			var checked = document.getElementById(id).isCh
			// /if()
			//create a record for each one that is
        });
	}
})