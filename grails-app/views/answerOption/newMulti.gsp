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
                	<g:hiddenField id="question-y-answerId-x" name="answer.id-x" value="0" />
	                <g:hiddenField id="answerOptionVersion-x" data-role="version" name="answer.version-x" value="" />
					<g:if test="${params.inputType == 'radio'}">
						<input type="radio" name="question-y-answer" />
					</g:if>
					<g:if test="${params.inputType == 'checkbox'}">
						<input type="checkbox" name="question-y-answer" />
					</g:if>
					<input type="text" 
					class="blurSave" 
					class="answerOption" 
					id="question-y-answer-x" 
					data-idInput="question-y-answerId-x" 
					data-versionInput="answerOptionVersion-x" 
					data-qTypeInput="qType-y" 
					data-controller="answerOption" 
					data-action="ajaxAnswerSave" 
					data-questionIdInput="questionId-y" 
					value="Click to add option" />
					
					<div class="ajaxMessage"></div>
					
					<input type="text" 
					class="associatedScore" 
					id="associatedScore-x" 
					data-controller="answerOption" 
					data-versionInput="answerOptionVersion-x"
					data-action="ajaxAssociatedScoreUpdate" 
					placeholder="0" />
					
					<div class="ajaxMessage"></div>
					
					<a href="#" title="Delete answer" class="delete" data-controller="answerOption" data-action="ajaxDelete"></a>
				</div>
			</li>
		</ul>
	</body>
</html>