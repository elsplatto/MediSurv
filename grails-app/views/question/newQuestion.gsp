<%@ page import="medisurv.Question" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
		<ul id="newQuestionList">
			<li data-id="0">
				<div class="qEditHolder" data-holderId="x" data-mode="edit" id="editDiv-x">
					<div class="q">
				        <g:hiddenField id="questionId-x" name="question.id-x" value="0" />
				        <g:hiddenField id="questionVersion-x" data-role="version" name="question.version-x" value="" />
						<label for="q-x">Question</label>
						<g:textField id="q-x" name="q-x" class="question" data-idInput="questionId-x" data-versionInput="questionVersion-x"  data-qTypeInput="qType-x" data-controller="question" data-action="ajaxQuestionSave" /><div class="ajaxMessage"></div>
					</div>
					<div class="qType">	
						<label for="qType-x">Question Type</label>											
						<g:select id="qType-x" class="qType" name="questionType-x" data-qInput="q-x" data-qTypeInput="qType-x" data-multipleAnswers="${(questionInstance?.questionType?.toLowerCase() == 'text' ? false : true)}"  from="${questionInstance.constraints.questionType.inList}" value="${questionInstance?.questionType}" valueMessagePrefix="questionInstance.questionType" />
					</div>	
					<div class="qAnswers">
						<ul id="answerList-x" data-controller="answerOption" data-action="setSequence">
							<!--li data-id="0"><input type="text" id="question-x-answer-x" 
								class="textAnswer" disabled="disabled" placeholder="Their answer" /></li-->
								
								
								<li data-id="0">	
														
					                <g:hiddenField id="answer-0" name="answer.id-0" value="0" />
					                <g:hiddenField id="answerOptionVersion-0" data-role="version" name="answer.version-0" value="" />
									<!--input type="text" id="question-0-answer-0" class="textAnswer" disabled="disabled" placeholder="Their answer" /-->
									<div class="multiHolder">
										<g:hiddenField id="question-0-answerId-0" name="answer.id-0" value="0" />
						                <g:hiddenField id="answerOptionVersion-0" data-role="version" name="answer.version-0" value="" />
										
										<input type="radio" name="question-0-answer" />
										<input type="text" 
										class="blurSave" 
										data-idInput="question-0-answerId-0" 
										data-versionInput="answerOptionVersion-0" 
										data-qTypeInput="qType-0" 
										data-controller="answerOption" 
										data-action="ajaxAnswerSave" 
										data-questionIdInput="questionId-0" 
										id="question-0-answer-0" 
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
								
								<li data-id="0" class="notSelectable">
									<div class="multiHolder">
								        <input type="hidden" id="question-x-answerId-1" name="answer.id-1" value="0">
						                <input type="hidden" id="answerOptionVersion-1" data-role="version" name="answer.version-1" value="">

										<input type="radio" name="question-x-answer" />
										<input type="text" 
										class="blurSave" 
										id="question-x-answer-1" 
										data-idInput="question-x-answerId-1" 
										data-versionInput="answerOptionVersion-1" 
										data-qTypeInput="qType-x" 
										data-controller="answerOption" 
										data-action="ajaxAnswerSave" 
										data-questionIdInput="questionId-x" 
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
					</div>
					<div class="qSubmit">
						<button type="button" id="qDone-x" data-qInput="q-x" data-viewDiv="viewDiv-x" data-editDiv="editDiv-x"  data-answerList="answerList-x" data-qTypeInput="qType-x" class="questionComplete">Done</button>
					</div>
				</div>
				<div class="qInputs" data-mode="view" id="viewDiv-x">
					<div id="qViewHolder-x" class="qViewHolder">
						
					</div>
					<a href="#" id="qEdit-x" data-viewDiv="viewDiv-x" data-editDiv="editDiv-x" class="questionEdit">Edit</a>
				</div>
			</li>
		</ul>
	</body>
</html>