$(function() {
	
	$('input[type="text"]').live('keypress',function(e)
	{
		//e.preventDefault();
		
	/*	if ((e.keyCode == 13) && (node.type=="text"))  
		{
			alert('keycode:'+e.keyCode)
			return false;
		}
	*/
	});
	
	var defaultTitle = "Untitled Survey"
	var defaultQuestion = "Question "
	
	if ($('input#title').length > 0 && $('input#title').val() == '')
	{
		$('input#title').val(defaultTitle);
		$('input#title').select();
	}

	//auto save on arrival at page
	if ($('input#title').length > 0)
	{
		var surveyId = $('input#id').val()
		if (parseInt(surveyId) == 0)
		{
			ajaxSurveySave($('input#title'),$('input#authorID'),true);
		}
	}
		
	var questionInputArr = $('input.question');
	
	if (questionInputArr.length > 0)
	{
		for (var i=0;i<questionInputArr.length;i++)
		{
			if ($(questionInputArr[i]).val() == '')
			{
				$(questionInputArr[i]).val(defaultQuestion + (i+1));
			}
		}
	}
	
	$('ul[id|="answerList"] li:last-child input[type="radio"] + input[type="text"], ul[id|="answerList"] li:last-child input[type="checkbox"] + input[type="text"],	ul[id|="answerList"] li:last-child .multiHolder input[type="text"]').live('focus',function(e) {
		var qIndex = getFirstNumberFromString($(this).attr('id'),'input focus');
		var aIndex = $('ul#answerList-'+qIndex+' li').length;
		$(this).val('Option '+(aIndex));
		$(this).closest('li').removeClass('notSelectable')
		var parentLI = $(this).closest('li');
		var parentUL = parentLI.closest('ul');
		var inputType = $('#qType-'+qIndex).val();	
		renderNewMulti(parentUL,qIndex,inputType);
	});
	
	$('a.questionEdit').live('click',function(e) {
		e.preventDefault();
		var editDiv = $('#'+$(e.target).attr('data-editDiv'));
		var viewDiv = $('#'+$(e.target).attr('data-viewDiv'));
		toggleDivs(viewDiv,editDiv);
		console.log('++++++++++++++++++++');
		console.log($(e.target).attr('id'));
		var num = getFirstNumberFromString($(e.target).attr('id'));	
		console.log(num);
		console.log('++++++++++++++++++++');
			
		//focus on question input
		$('#q-'+ num).select();
	});
	
	$('button.questionComplete').live('click',function(e) {
		e.preventDefault();
		var questionInput = $('#'+$(e.target).attr('data-qInput'));
		var questionId = $('#'+questionInput.attr('data-idInput')).val();
		var answerListEl = $('#'+$(this).attr('data-answerList'));
		if (parseInt(questionId) > 0)
		{
			ajaxQuestionUpdate(questionInput);
		}
		else
		{
			ajaxQuestionSave(questionInput);
		}
		renderViewMode($(this));
		var viewDiv = $('#'+$(this).attr('data-viewDiv'));
		var editDiv = $('#'+$(this).attr('data-editDiv'));
		toggleDivs(editDiv,viewDiv);
	});
	
	$('a#addQuestion').live('click',function(e) {
		e.preventDefault();
		var questionInput = $('ul#questionList li[data-id="0"]').find('input.question');
		var questionId = $('#'+questionInput.attr('data-idInput')).val();
		var lastDoneButton = $('ul#questionList li:last-child').find('button[id^="qDone-"]');
		if (questionId) 
		{
			if (parseInt(questionId) > 0)
			{
				ajaxQuestionUpdate(questionInput);
			}
			else
			{
				ajaxQuestionSave(questionInput);
			}
			var parentLI = questionInput.closest('li');
			var parentUL = parentLI.closest('ul');
			renderNewQuestion(parentUL);
			
		}
		else 
		{
			renderNewQuestion($('#questionList'));
			
		}
		
		if (lastDoneButton.not(':hidden'))
		{
			//if view mode hasn't been executed on last question
			renderViewMode(lastDoneButton);
		}
				
		var viewDiv = $('#'+lastDoneButton.attr('data-viewDiv'));
		var editDiv = $('#'+lastDoneButton.attr('data-editDiv'));
		toggleDivs(editDiv,viewDiv);
	});
	
	
	
	$('input#title').bind('blur',function()
	{
		if ($(this).val() === '')
		{
			$(this).val(defaultTitle);
		}
		var surveyId = $('input#id').val()
		if (parseInt(surveyId) > 0)
		{
			ajaxSurveyUpdate($(this));
		}
		else
		{
			ajaxSurveySave($(this),$('input#authorID'),true);
		}		
	});
	
	$('input[type="text"].question').live('blur',function(e)
	{
		var qId = $(this).closest('li[data-Id]').attr('data-Id');
		if (qId > 0) 
		{
			ajaxQuestionUpdate($(this));
		}
		else
		{
			ajaxQuestionSave($(this));
		}
	});
	
	$('input.blurSave, input.associatedScore').live('blur',function(e)
	{
		var dataId = parseInt($(this).closest('li[data-Id]').attr('data-Id'));
		var className = $(this).attr('class').toLowerCase();
		var action = $(this).attr('data-action');
		
		
		if (dataId === 0 && className === "blursave")
		{
			ajaxAnswerSave($(this));
		}
		else if (dataId > 0 && className === "blursave")
		{
			ajaxAnswerUpdate($(this));
		}
		else if (dataId > 0 && className === "associatedscore")
		{
			ajaxAssociatedScoreUpdate($(this),dataId);
		}
		
	});
	
	$('a.delete').live('click',function(e)
	{
		e.preventDefault();
		$(this).focus();
		ajaxDelete($(this));
		//renderDeleteConfirm($(this));
		
	})
	
	$('a.confirmDelete').live('click',function(e) 
	{
		e.preventDefault();
		ajaxDelete($(this));
	});

	$('a.cancelDelete').live('click',function(e) 
	{
		e.preventDefault();
		var listEl = $(this).closest('li');
		listEl.find('.hide4Confirm').removeClass('hide4Confirm');
		var target = $(this).closest('div.deleteHolder').remove();
	});

	$('select.qType').live('change',function(e) {
		console.log('===================================================');
		console.log('question type called');
		var selectedQType = $(this).val().toLowerCase();
		var parentLI = $(this).closest('li');
		var questionId = parentLI.attr('data-id');
		var wasMultiple = $(this).attr('data-multipleAnswers');
		var nextAnswerDiv = $(this).closest('div.qType').next('div.qAnswers');
		
		var qIndex = getFirstNumberFromString($(this).attr('id'));
		var targetUL = $('#answerList-'+qIndex.toString());
		
		console.log('selectedQType: ' + selectedQType);
		console.log('===================================================');
		
		
		if (questionId > 0 && wasMultiple)
		{
			//user has changed the question type - get rid of existing answer options for this question
			ajaxDeleteOldAnswerOption(questionId);
			targetUL.remove();		
		}
		if (selectedQType === 'radio' || selectedQType === 'checkbox' || selectedQType === 'select')
		{
			//initialiseMulti($(this),selectedQType);
			resetMulti(nextAnswerDiv,qIndex,selectedQType)
			$(this).attr('data-multipleAnswers','true');
		}
		else if (selectedQType === 'text')
		{
			initialiseTextOption($(this),nextAnswerDiv,'text');
			$(this).attr('data-multipleAnswers','false');
		}		
		else if (selectedQType === 'textarea')
		{
			initialiseTextareaOption($(this),nextAnswerDiv,'textarea');
			$(this).attr('data-multipleAnswers','false');
		}
		saveUpdateQuestionType($(this));
	});
	
	
	function resetMulti(target,qIndex,qTypeInput) {
		console.log('===================================================');
		console.log('renderNewMulti called');
		var newLIIndex = target.children('li').length;		
		target.append('<ul id="answerList-'+qIndex+'" class="sortable" data-controller="answerOption" data-action="setSequence"></ul>');
		target.children('ul').load('/MediSurv/answerOption/resetMulti?inputType='+qTypeInput.toLowerCase()+'&questionIndex='+qIndex+' #newAnswerList li',function(responseText, textStatus, XMLHttpRequest) 
		{
		   	console.log('===================================================');
			console.log('New Multi Ajax retrieve');
		    console.log('XMLHttpRequest Status Code: ' + XMLHttpRequest.status + ' - XMLHttpRequest Status Text: ' + XMLHttpRequest.statusText);
			console.log('===================================================');
			if (XMLHttpRequest.statusText.toLowerCase() === 'ok' || XMLHttpRequest.statusText.toLowerCase() === 'success')
			{
				//select goes here once load has been succesful
				$('#question-'+qIndex+'-answer-0').select();
			}
			
		});
		console.log('===================================================');
	}
	
	
	function ajaxAssociatedScoreUpdate(el,associatedAnswerId) {
		ajaxIndicator(el,'loading','');
		var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		var queryString = '';
		var frmAction = '/MediSurv/'+controller+'/'+action;
		var associatedScore = parseInt('0'+el.val());
		var objVersionInput = $('#'+el.attr('data-versionInput'));
		var version = objVersionInput.val();
		var ajaxMessage = '';
							
		queryString += '&id='+associatedAnswerId+'&associatedScore='+associatedScore+'&version='+version;
		
		
		console.log('===========================================');
		console.log('ajaxAssociatedScoreUpdate called');
		console.log('querystring: ['+queryString+']');
		console.log("element ID: "+el.attr("id"));
		console.log("associatedAnswerId: "+associatedAnswerId);
		console.log('===========================================');
		
		
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				
				console.dir(data);
				console.log(data.result.message);
				
				ajaxMessage = data.result.message;
				
				objVersionInput.val(version);
				ajaxIndicator(el,'success',ajaxMessage);
			},
			error: function(data)
			{
				ajaxMessage = data.result.message;
				ajaxIndicator(el,'error',ajaxMessage);
				
				console.log('*************************************');
				console.dir(data);
				console.log(data.statusText);
				console.log('*************************************');
			}
		});
	}
	
	function ajaxDeleteOldAnswerOption(id)
	{
		
		console.log('===========================================');
		console.log('ajaxDeleteOldAnswerOption called');
		console.log('');
		console.log('===========================================');
		
		var controller = 'answerOption';
		var action = 'ajaxDeleteOldAnswerOption';				
		var frmAction = '/MediSurv/'+controller+'/'+action;		
		var queryString = '';
		queryString = '&question.id='+id;
				
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				//console.log('here');
				//console.dir(data)
				//console.log('ajaxDeleteOldAnswerOption data result message: '+data.result.message)
				var ajaxSuccess = data.result.success;
				var ajaxMessage = data.result.message;
				if (ajaxSuccess)
				{
					$('#deleteAjaxMessage').text(ajaxMessage);
				}
				return ajaxSuccess
			}
		});
	}
	
	function renderDeleteConfirm(el) 
	{
		var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		var listEl = el.closest('li');
		listEl.children('div, input').addClass('hide4Confirm');		
		var html = '';
		html += '<div class="deleteHolder">';
		html += '<span class="confirmDelete">Are you sure you want to delete this item?</span>'
		html += '<a href="#" class="confirmDelete" data-action="'+action+'" data-controller="'+controller+'">Confirm</a>'
		html += '<a href="#" class="cancelDelete">Cancel</a>'
		html += '</div>';
		
		listEl.append(html)
	}
	
	function ajaxDelete(el)
	{
		var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		
		var itemId = el.closest('li[data-Id]').attr('data-Id');		
		var frmAction = '/MediSurv/'+controller+'/'+action;
		
		var queryString = '';
		queryString = '&id='+itemId;
		
		/*
		console.log('===========================================');
		console.log('ajaxDelete called');
		console.log('frmAction: ['+frmAction+']');
		console.log('queryString['+queryString+']');
		console.log('===========================================');
		*/
		
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				//console.log('here');
				//console.dir(data)
				//console.log(data.result.message)
				var ajaxSuccess = data.result.success;
				var ajaxMessage = data.result.message;
				if (ajaxSuccess)
				{
					el.closest('li[data-Id]').remove();
					$('#deleteAjaxMessage').text(ajaxMessage);
				}
			}
		});
	}
	
	function ajaxUpdateAssociateScore(e) {
		
	}

	function ajaxAnswerSave(el)
	{
		ajaxIndicator(el,'loading','');
		var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		var idInput = el.attr('data-idInput');
		var objIdInput = $('#'+idInput);
		var objVersionInput = $('#'+el.attr('data-versionInput'));
		var inputLabel = el.val();
		var questionId = el.closest('ul').closest('li[data-Id]').attr('data-Id');
		var questionType = $('#'+el.attr('data-qTypeInput')).val().toLowerCase() ;
		var itemSequence = el.closest('ul').children('li').index(el.closest('li'));
		var queryString = '';
		var frmAction = '/MediSurv/'+controller+'/'+action;
		var ajaxMessage = '';
		
		queryString += '&question.id='+questionId+'&inputLabel='+inputLabel+'&questionType='+questionType+'&sequence='+itemSequence+'&isOther=false';		
			
		console.log('===========================================');
		console.log('ajaxAnswerSave called');
		console.log('frmAction: ['+frmAction+']');
		console.log("save answer Option queryString["+queryString+"]");
		console.log('===========================================');
		
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				console.log('===========================================');
				console.log('ajaxAnswerSave success');
				
				ajaxMessage = data.result.message;
				var newId = data.result.newID;
				var version = data.result.version;
				//console.log('ajax save answer outcome: ' + ajaxMessage);
				if (parseInt(newId) > 0)
				{
					//console.log('newID: '+newId)
					objIdInput.val(newId);
					el.closest('li').attr('data-id',newId);
					objVersionInput.val(version);
					el.attr('data-action','ajaxAnswerUpdate');
					ajaxIndicator(el,'success',ajaxMessage);
				}
				console.log('newID: ['+newId+']');
				console.log('===========================================');
			},
			error: function(data)
			{	
				ajaxMessage = data.result.message;			
				ajaxIndicator(el,'error',ajaxMessage);
			}
		});
	}
	
	function ajaxAnswerUpdate(el)
	{
		
		ajaxIndicator(el,'loading','');
		var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		var idInput = el.attr('data-idInput');		
		var answerOptionIndex = getFirstNumberFromString(el.attr('data-versionInput'),'ajaxAnswerUpdate');
		var associatedScore = parseInt('0'+$('#associated-Score-'+answerOptionIndex+'').val());
		var objIdInput = $('#'+idInput);
		var inputLabelId = objIdInput.val();
		var versionInput = el.attr('data-versionInput');
		var objVersionInput = $('#'+versionInput);
		var inputLabelVersion = objVersionInput.val();
		var inputLabel = el.val();
		var questionType = $('#'+el.attr('data-qTypeInput')).val();
		var questionId = el.closest('ul').closest('li[data-Id]').attr('data-Id');
		var queryString = '';
		var frmAction = '/MediSurv/'+controller+'/'+action;
		var ajaxMessage = '';
							
		queryString += '&id='+inputLabelId+'&inputLabel='+inputLabel+'&associatedScore='+associatedScore+'&question.id='+questionId+'&version='+inputLabelVersion+'&questionType='+questionType+'&isOther=false';
		
		
		console.log('===================================================');
		console.log('ajaxAnswerUpdate called');
		console.log('element calling function: ['+el.attr('id')+']');
		console.log('frmAction: ['+frmAction+']');
		console.log('queryString: ['+queryString+']');
		console.log('associatedScore: ['+associatedScore+']');
		console.log('===================================================');
		
		
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				//console.dir(data);
				//console.log(data.result.message);
				
				ajaxMessage = data.result.message;
				var version = data.result.version;
				objVersionInput.val(version);
				
				ajaxIndicator(el,'success',ajaxMessage);
			},
			error: function(data)
			{	
				ajaxMessage = data.result.message;
				ajaxIndicator(el,'error',ajaxMessage);
			}
		});
	}
	
	function ajaxQuestionSave(el)
	{		
		ajaxIndicator(el,'loading','');
		var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		var idInput = el.attr('data-idInput');
		var objIdInput = $('#'+idInput);
		var versionInput = el.attr('data-versionInput');
		var objVersionInput = $('#'+versionInput);
		var surveyId = $('input#id').val();
		var question = el.val();
		var questionType = $('#'+el.attr('data-qTypeInput')).val();
		var itemSequence = el.closest('ul').children('li').index(el.closest('li'));
		var queryString = '';
		var frmAction = '/MediSurv/'+controller+'/'+action;
		var ajaxMessage = '';
							
		queryString += '&survey.id='+surveyId+'&sequence='+itemSequence+'&question='+question+'&questionType='+questionType;		
		//console.log("question queryString["+queryString+"]")
		
		console.log('===================================================');
		console.log('ajaxQuestionSave called');
		console.log('frmAction: ['+frmAction+']');
		console.log('queryString: ['+queryString+']');
		
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				console.log('Successful question save');
				ajaxMessage = data.result.message;
				var newId = data.result.newID;
				console.log('New question ID: ['+newId+']')
				var version = data.result.version;
				if (parseInt(newId) > 0)
				{
					objIdInput.val(newId);
					objIdInput.closest('li').attr('data-id',newId);
					objVersionInput.val(version);
					el.attr('data-action','ajaxQuestionUpdate');
					
					ajaxIndicator(el,'success',ajaxMessage);
				}
			},
			error: function(data)
			{	
				ajaxMessage = data.result.message;			
				ajaxIndicator(el,'error',ajaxMessage);
			}
		});
		
		console.log('===================================================');
	}
	
	function ajaxQuestionUpdate(el)
	{		
		ajaxIndicator(el,'loading','');
		var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		var idInput = el.attr('data-idInput');
		var objIdInput = $('#'+idInput);
		var questionId = objIdInput.val();
		var versionInput = el.attr('data-versionInput');
		var objVersionInput = $('#'+versionInput);
		var questionVersion = objVersionInput.val();
		var surveyId = $('input#id').val();
		var question = el.val();
		var questionType = $('#'+el.attr('data-qTypeInput')).val();
		var queryString = '';
		var frmAction = '/MediSurv/'+controller+'/'+action;
		var ajaxMessage = '';
							
		queryString += '?survey.id='+surveyId+'&question='+question+'&id='+questionId+'&version='+questionVersion+'&questionType='+questionType;
		
		console.log('===================================================');
		console.log('ajaxQuestionUpdate called');
		console.log('frmAction: ['+frmAction+']');
		console.log('queryString: ['+queryString+']');
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				console.log('Successful question update');
				ajaxMessage = data.result.message;
				var version = data.result.version;
				objVersionInput.val(version);
								
				ajaxIndicator(el,'success',ajaxMessage);
			},
			error: function(data)
			{	
				console.log('Error during question update');
				ajaxMessage = data.result.message;
				ajaxIndicator(el,'error',ajaxMessage);
			}
		});		
		console.log('===================================================');
		
	}
	
	function ajaxSurveySave(el,authorEl,isFirstQuestion)
	{
		ajaxIndicator(el,'loading','');
	    var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		var queryString = "";
		var frmAction = '/MediSurv/'+controller+'/'+action;
		var authorId = authorEl.val();
		var ajaxMessage = '';
					
		queryString += '&title='+el.val()+'&author.id='+authorId;
		
		console.log('===================================================');
		console.log('ajaxSurveySave called');
		console.log('frmAction: ['+frmAction+']');
		console.log('queryString: ['+queryString+']');
		console.log('===================================================');
		
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				//console.dir(data)
				//console.log(data.result.message)
				ajaxMessage = data.result.message;
				var newId = data.result.newID;
				var version = data.result.version;
				if (parseInt(newId) > 0)
				{
					$('input#id').val(newId);
					$('input#version').val(version);
					el.attr('data-action','ajaxSurveyUpdate');
					//for conventional post
					$('#submitButton').val('Update').attr('name','_action_update');
					el.closest('form').attr('action','/MediSurv/'+controller+'/index');
					$('body h1:eq(0)').text('Edit Survey');
				}
				
				if (isFirstQuestion) 
				{
					//auto save first question
					ajaxQuestionSave($('#q-0'));
				}
				ajaxIndicator(el,'success',ajaxMessage);
			},
			error: function(data)
			{	
				ajaxMessage = data.result.message;
				ajaxIndicator(el,'error',ajaxMessage);
			}
		});
	}
	
	function ajaxSurveyUpdate(el)
	{
		ajaxIndicator(el,'loading','');
		var id = $('input#id').val();
		var version = $('input#version').val();
		var controller = el.attr('data-controller');
		var action = el.attr('data-action');
		var queryString = '';
		var frmAction = '/MediSurv/'+controller+'/'+action;
		var ajaxMessage = '';
		
		queryString = '&id='+id+'&title='+el.val()+'&version='+version;
		
		console.log('===================================================');
		console.log('ajaxSurveyUpdate called');
		console.log('frmAction: ['+frmAction+']');
		console.log('queryString: ['+queryString+']');
		console.log('===================================================');
				
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				//console.dir(data)
				//console.log(data.result.message)
				ajaxMessage = data.result.message;
				var version = data.result.version;
				$('input#version').val(version);
				ajaxIndicator(el,'success',ajaxMessage);
			},
			error: function(data)
			{
				ajaxMessage = data.result.message;
				ajaxIndicator(el,'error',ajaxMessage);
			}
		});
	}

	function ajaxIndicator(el,status,ajaxMessage)
	{
		ajaxMessageEl = el.next('.ajaxMessage');
		switch (status)
		{
			case 'success':	
				ajaxMessageEl.html('');
				ajaxMessageEl.removeClass('loading');
				ajaxMessageEl.html('<img src="/MediSurv/images/success.png" alt="'+ajaxMessage+'" />');
				ajaxMessageEl.children('img').delay(1500).fadeOut(1000);			
				break;
			case 'error':
				ajaxMessageEl.html('');		
				ajaxMessageEl.removeClass('loading');
				ajaxMessageEl.html('<img src="/MediSurv/images/error.png" alt="'+ajaxMessage+'" />');
				break;
			case 'loading':				
				ajaxMessageEl.html('');
				ajaxMessageEl.removeClass('error');
				ajaxMessageEl.addClass('loading');
				break;
		}
	}
	
	/*$('a[title]').tooltip();*/

	$('ul.sortable').sortable({
		placeholder:'placeholder',
		items:'li:not(.notSelectable)',
		containment:'parent',
		revert: true,
		forcePlaceholderSize: true
	}).bind('sortupdate', function (event,ui)
		{
			var dragParent = ui.item.parent();
			if (parseInt('0'+ui.item.attr('data-id')) > 0)
			{		
				ajaxUpdateSequence(dragParent);
			}
		});
	
	function ajaxUpdateSequence(parentEl)
	{
		var queryString = '';
		var arrList = parentEl.children('li:not(.notSelectable)');		
		var action = parentEl.attr('data-action');
		var controller = parentEl.attr('data-controller');
		var frmAction = '/MediSurv/'+controller+'/'+action;
		
		
		console.log('===================================================');
		console.log('ajaxUpdateSequence called');
		console.log('frmAction: ['+frmAction+']');
		console.log('===================================================');
		
		for (var i=0;i<arrList.length;i++)
		{
			if (parseInt($(arrList[i]).attr('data-id')) > 0 && $(arrList[i]).hasClass('notSelectable') == false)
			{
				queryString += '&id='+$(arrList[i]).attr('data-id');
				//console.log("["+queryString+"]class["+$(arrList[i]).attr('class')+"]");
			}
		}
				
		$.ajax(
        {
            type: 'POST',
            data: queryString,
            url: frmAction,
            success: function(data) 
			{
				//console.log('successful sort');
				//console.log('arrList length: ' +arrList.length )
				var versionInput;
				for (i=0;i<arrList.length;i++)
				{
					//console.log('loop pos: '+i);
					//console.log('controller: '+controller);
					versionInput = $(arrList[i]).find('input[id^="'+controller+'Version"]');
					//console.log('['+versionInput.attr('id')+']');
					versionInput.val(parseInt(versionInput.val())+1);
				}
			}
		});		
	}
	
	

	function renderNewMulti(target,qIndex,qTypeInput) {
		console.log('===================================================');
		console.log('renderNewMulti called');
		var newLIIndex = target.children('li').length;		
		target.append('<li data-id="0" class="notSelectable"></li>');
		target.children('li:last-child').load('/MediSurv/answerOption/newMulti?inputType='+qTypeInput.toLowerCase()+' #newAnswerList li div.multiHolder',function(responseText, textStatus, XMLHttpRequest) 
		{
		   	console.log('===================================================');
			console.log('New Multi Ajax retrieve');
		    console.log('XMLHttpRequest Status Code: ' + XMLHttpRequest.status + ' - XMLHttpRequest Status Text: ' + XMLHttpRequest.statusText);
			console.log('===================================================');
		   
		
			target.find('*').filter(function()
			{ 
			    for (var i = 0; i < this.attributes.length; i++)
			    {
			        var attr = this.attributes[i];
					if (attr.nodeValue.indexOf('-x') > 0 && attr.nodeValue.indexOf('-y') > 0)
					{
						//global replace on attr
						attr.nodeValue = attr.nodeValue.replace(/-x/g,'-'+newLIIndex);
						attr.nodeValue = attr.nodeValue.replace(/-y/g,'-'+qIndex);
					}
					else if (attr.nodeValue.indexOf('-x') > 0 && attr.nodeValue.indexOf('-y') < 0) {//global replace on attr
						attr.nodeValue = attr.nodeValue.replace(/-x/g,'-'+newLIIndex);
					}
					else if (attr.nodeValue.indexOf('-y') > 0 && attr.nodeValue.indexOf('-x') < 0) {//global replace on attr
						attr.nodeValue = attr.nodeValue.replace(/-y/g,'-'+qIndex);
					}
					else if (attr.name.toLowerCase() == "data-holderid" && attr.nodeValue == "x")
					{
						attr.nodeValue = newLIIndex;
					}
					else if (attr.name.toLowerCase() == "type" && attr.nodeValue == "radio" && qTypeInput == "checkbox")
					{
						attr.nodeValue = "checkbox"
					}
					else if (attr.name.toLowerCase() == "type" && (attr.nodeValue == "radio" || attr.nodeValue == "checkbox") && qTypeInput == "select")
					{
						this.remove();
					}
			    }
			});
		});
		console.log('===================================================');
	}
	
	function renderNewQuestion(target)
	{
		var newLIIndex = target.children('li').length;
		//target.css({backgroundColor:'#f00'})
		target.append('<li data-id="0"></li>');
		target.children('li:last-child').load('/MediSurv/question/newQuestion #newQuestionList li div[data-mode]',function() {			
			target.find('*').filter(function()
			{ 
			    for (var i = 0; i < this.attributes.length; i++)
			    {
			        var attr = this.attributes[i];
					if (attr.nodeValue.indexOf('-x') > 0)
					{
						//global replace on attr
						attr.nodeValue = attr.nodeValue.replace(/-x/g,'-'+newLIIndex);
					}
					else if (attr.name.toLowerCase() == "data-holderid" && attr.nodeValue == "x")
					{
						attr.nodeValue = newLIIndex;
					}
			    }
				$('#q-'+newLIIndex+'').val(defaultQuestion + (newLIIndex+1));
				$('#q-'+newLIIndex+'').select();
			});
		});
	}	
	
	function toggleDivs(hideDiv,showDiv) {
		hideDiv.hide();
		showDiv.show();
	}
	
	
	
	function renderViewMode(el) {		
		
		console.log('===================================================');
		console.log('renderViewMode called');
		console.log('===================================================');
		
		var viewDivStr = el.attr('data-viewDiv');
		var targetDiv = $('#'+viewDivStr).children('div.qViewHolder');
		var elKey = getFirstNumberFromString(viewDivStr,'renderViewMode');
		var objQuestionInput = $('#'+el.attr('data-qInput'));
		var objAnswerList = $('#'+el.attr('data-answerList'));
		var objQuestionType = $('#'+el.attr('data-qTypeInput'));
		var strQType = objQuestionType.val();
		
		
		var arrAnswerListItems = objAnswerList.children('li');
		var inputEl;
		var labelEl;
		var i;
		var html = '<label class="question">'+objQuestionInput.val()+'</label><a href="#" class="delete" data-controller="question" data-action="ajaxDelete"></a>';
		html += '<ul class="viewOptions">';
		if (strQType.toLowerCase() === 'radio' || strQType.toLowerCase() === 'checkbox')
		{
			for (i=0;i<(arrAnswerListItems.length-1);i++)
			{
				inputEl = $(arrAnswerListItems[i]).find('input[type="radio"]');
				labelEl = $(arrAnswerListItems[i]).find('input[type="text"]');
				html += '<li class="notSelectable"><input type="'+strQType+'" id="multi-'+labelEl.attr('id')+'" name="'+inputEl.attr('name')+'">';
				html += '<label for="multi-'+labelEl.attr('id')+'">';
				html += labelEl.val();
				html += '</label></li>';
			}
		}
		else if (strQType.toLowerCase() === 'select')
		{
			html += '<li class="notSelectable"><select>'
			for (i=0;i<(arrAnswerListItems.length-1);i++)
			{
				labelEl = $(arrAnswerListItems[i]).find('input[type="text"]');
				html += '<option>';
				html += labelEl.val();
				html += '</option>';
			}
			html += '<select></li>'
		}
		else if (strQType.toLowerCase() === 'text')
		{
			html += '<li class="notSelectable"><input type="text" class="textAnswer" disabled="disabled" placeholder="Their answer" /></li>'
		}		
		else if (strQType.toLowerCase() === 'textarea')
		{
			html += '<li class="notSelectable"><textarea disabled="disabled" placeholder="Their answer"></textarea></li>'
		}
		html += '</ul>';
		targetDiv.html(html);
		
	}
	
	function renderViewInput(idNum)
	{
		var html = '<label>'+$('#q-'+idNum).val()+'</label>';
		$('#qViewHolder-'+idNum).html(html);
	}
	
	
	function initialiseTextOption(el,nextAnswerDiv,inputType){
		var html = '';
		var qIndex = getFirstNumberFromString(el.attr('id'),'initialiseTextOption');
		qIndex.toString();
		if (inputType == 'text')
		{
			html += '<ul id="answerList-'+qIndex+'">';
			html += '<li>';
			html += '<input type="text" id="question-'+qIndex+'-answer-0" class="textAnswer" disabled="disabled" placeholder="Their answer" />';
			html += '</li>';
			html += '</ul>';
		}
		nextAnswerDiv.html(html);
	}
	
	function initialiseTextareaOption(el,nextAnswerDiv,inputType){
		console.log('==================================================================');
		console.log('initialiseTextareaOption called');
		console.log('el:' + el);
		console.log('inputType:' + inputType);
		var html = '';
		var qIndex = getFirstNumberFromString(el.attr('id'),'initialiseTextareaOption');
		qIndex.toString();
		console.log('ul#answerList-'+qIndex);
		console.log('==================================================================');
		if (inputType == 'textarea')
		{
			html += '<ul id="answerList-'+qIndex+'">';
			html += '<li>';
			html += '<textarea disabled="disabled" placeholder="Their answer"></textarea>';
			html += '</li>';
			html += '</ul>';
		}
		nextAnswerDiv.html(html);
	}
	
	function getFirstNumberFromString(s) {
		
		console.log('===================================================');
		console.log('getFirstNumberFromString called');
		console.log("getFirstNumberFromString - string passed was: ["+s+"]")
		if (s !== undefined)
		{
			console.log("getFirstNumberFromString != undefined")
			var startPos = s.indexOf('-')+1;
			var endPos = s.indexOf('-',startPos);
			console.log('startPos['+startPos+']endPos['+startPos+']');
			var num;
			if (endPos > -1)
			{
				num = s.substring(startPos,endPos);
			}
			else
			{
				num = s.substring(startPos);
			}	
			console.log('getFirstNumberFromString return:['+num+']')
			console.log('returning')
			return num;
		}
		console.log('===================================================');
	}
	
	function saveUpdateQuestionType(el) {
		var qId = el.closest('li[data-Id]').attr('data-Id');
		var qInput = $('#'+el.attr('data-qInput'));
		if (qId > 0) {
			ajaxQuestionUpdate(qInput);
		}
		else
		{
			ajaxQuestionSave(qInput);
		}
	}
	
});

/* HTML5 Sortable (http://farhadi.ir/projects/html5sortable)
 * Released under the MIT license.
 */(function(a){var b,c=a();a.fn.sortable=function(d){var e=String(d);return d=a.extend({connectWith:!1},d),this.each(function(){if(/^enable|disable|destroy$/.test(e)){var f=a(this).children(a(this).data("items")).attr("draggable",e=="enable");e=="destroy"&&f.add(this).removeData("connectWith items").off("dragstart.h5s dragend.h5s selectstart.h5s dragover.h5s dragenter.h5s drop.h5s");return}var g,h,f=a(this).children(d.items),i=a("<"+(/^ul|ol$/i.test(this.tagName)?"li":"div")+' class="sortable-placeholder">');f.find(d.handle).mousedown(function(){g=!0}).mouseup(function(){g=!1}),a(this).data("items",d.items),c=c.add(i),d.connectWith&&a(d.connectWith).add(this).data("connectWith",d.connectWith),f.attr("draggable","true").on("dragstart.h5s",function(c){if(d.handle&&!g)return!1;g=!1;var e=c.originalEvent.dataTransfer;e.effectAllowed="move",e.setData("Text","dummy"),h=(b=a(this)).addClass("sortable-dragging").index()}).on("dragend.h5s",function(){b.removeClass("sortable-dragging").show(),c.detach(),h!=b.index()&&f.parent().trigger("sortupdate",{item:b}),b=null}).not("a[href], img").on("selectstart.h5s",function(){return this.dragDrop&&this.dragDrop(),!1}).end().add([this,i]).on("dragover.h5s dragenter.h5s drop.h5s",function(e){return!f.is(b)&&d.connectWith!==a(b).parent().data("connectWith")?!0:e.type=="drop"?(e.stopPropagation(),c.filter(":visible").after(b),!1):(e.preventDefault(),e.originalEvent.dataTransfer.dropEffect="move",f.is(this)?(d.forcePlaceholderSize&&i.height(b.outerHeight()),b.hide(),a(this)[i.index()<a(this).index()?"after":"before"](i),c.not(i).detach()):!c.is(this)&&!a(this).children(d.items).length&&(c.detach(),a(this).append(i)),!1)})})}})(jQuery);
