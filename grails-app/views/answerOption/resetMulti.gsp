<%@ page import="medisurv.AnswerOption" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'question.label', default: 'AnswerOption')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
		<ul id="newAnswerList">
			
			
			<li data-id="0">	
				
				<div class="multiHolder">
					
					<g:hiddenField id="question-${params.questionIndex}-answerId-0" name="answer.id-0" value="0" />
	                <g:hiddenField id="answerOptionVersion-0" data-role="version" name="answer.version-0" value="" />
					<g:if test="${params.inputType == 'radio'}">
						<input type="radio" name="question-${params.questionIndex}-answer" />
					</g:if>
					<g:if test="${params.inputType == 'checkbox'}">
						<input type="checkbox" name="question-${params.questionIndex}-answer" />
					</g:if>
					<input type="text" 
					class="blurSave" 
					data-idInput="question-${params.questionIndex}-answerId-0" 
					data-versionInput="answerOptionVersion-0" 
					data-qTypeInput="qType-${params.questionIndex}" 
					data-controller="answerOption" 
					data-action="ajaxAnswerSave" 
					data-questionIdInput="questionId-${params.questionIndex}" 
					id="question-${params.questionIndex}-answer-0" 
					value="Option 1" />
				
					<div class="ajaxMessage"></div>
				
					<input type="text" 
					class="associatedScore" 
					id="associatedScore-0" 
					data-controller="answerOption" 
					data-versionInput="answerOptionVersion-0"
					data-action="ajaxAssociatedScoreUpdate" 
					placeholder="0" />
					
					<div class="ajaxMessage"></div>
				
					<a href="#" title="Delete answer" class="delete" data-controller="answerOption" data-action="ajaxDelete"></a></div>
			</li>
			
			<li data-id="0">
				<div class="multiHolder">
                	<g:hiddenField id="question-${params.questionIndex}-answerId-1" name="answer.id-1" value="0" />
	                <g:hiddenField id="answerOptionVersion-1" data-role="version" name="answer.version-1" value="" />
					<g:if test="${params.inputType == 'radio'}">
						<input type="radio" name="question-${params.questionIndex}-answer" />
					</g:if>
					<g:if test="${params.inputType == 'checkbox'}">
						<input type="checkbox" name="question-${params.questionIndex}-answer" />
					</g:if>
					<input type="text" 
					class="blurSave" 
					class="answerOption" 
					id="question-${params.questionIndex}-answer-1" 
					data-idInput="question-${params.questionIndex}-answerId-1" 
					data-versionInput="answerOptionVersion-1" 
					data-qTypeInput="qType-${params.questionIndex}" 
					data-controller="answerOption" 
					data-action="ajaxAnswerSave" 
					data-questionIdInput="questionId-${params.questionIndex}" 
					value="Click to add option" />
					
					<div class="ajaxMessage"></div>
					
					<input type="text" 
					class="associatedScore" 
					id="associatedScore-1" 
					data-controller="answerOption" 
					data-versionInput="answerOptionVersion-1"
					data-action="ajaxAssociatedScoreUpdate" 
					placeholder="0" />
					
					<div class="ajaxMessage"></div>
					
					<a href="#" title="Delete answer" class="delete" data-controller="answerOption" data-action="ajaxDelete"></a>
				</div>
			</li>
		</ul>
	</body>
</html>