<%@ 
page import="medisurv.MediSurvey"
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mediSurvey.label', default: 'MediSurvey')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
			<div class="contentArea">
            	<!--h1>Create Survey</h1-->
				<div id="deleteAjaxMessage"></div>
	            <g:if test="${flash.message}">
	            <div class="message">${flash.message}</div>
	            </g:if>
	            <g:hasErrors bean="${mediSurveyInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${mediSurveyInstance}" as="list" />
	            </div>
	            </g:hasErrors>
	            <g:form action="save">
	                <div class="dialog">
	                    <table class="surveyFields">
	                        <tbody>                        
	                            <tr class="prop">
	                                <td class="name">
	                                    <label for="title"><g:message code="mediSurvey.title.label" default="Title" /></label>
	                                </td>
	                                <td class="value ${hasErrors(bean: mediSurveyInstance, field: 'title', 'errors')}">
										<g:hiddenField id="id" name="id" value="0" />
						                <g:hiddenField id="version" name="version" value="" />
	                                    <g:textField id="title" name="title" value="${mediSurveyInstance?.title}" data-controller="mediSurvey" data-action="ajaxSurveySave" /><div class="ajaxMessage"></div>
	                                </td>
	                            </tr>

								
								 <tr class="prop">
	                                <td class="name label">
		                                  <label for="questions"><g:message code="mediSurvey.questions.label" default="Questions" /></label>
		                                </td>
		                                <td class="questions ${hasErrors(bean: mediSurveyInstance, field: 'questions', 'errors')}">


									
				                        <ul id="questionList" class="buttonList sortable" data-controller="question" data-action="setSequence">				
											<li data-id="0">
												<div class="qEditHolder" data-holderId="0" data-mode="edit" id="editDiv-0">
													<div class="q">
										                <g:hiddenField id="questionId-0" name="question.id-0" value="0" />
										                <g:hiddenField id="questionVersion-0" data-role="version" name="question.version-0" value="" />
														<label for="q-0">Question</label>
														<g:textField id="q-0" name="q-0" class="question" data-idInput="questionId-0" data-versionInput="questionVersion-0" data-qTypeInput="qType-0" data-controller="question" data-action="ajaxQuestionSave" /><div class="ajaxMessage"></div>
													</div>
													<div class="qType">
														<label for="qType-0">Question Type</label>											
														<g:select id="qType-0" class="qType" name="questionType-0" data-qInput="q-0" data-multipleAnswers="true"  from="${questionInstance.constraints.questionType.inList}" value="${questionInstance?.questionType}" valueMessagePrefix="questionInstance.questionType" />
													</div>
													<div class="qAnswers">
														<ul id="answerList-0" data-controller="answerOption" data-action="setSequence">
															<li data-id="0" data-controller="answerOption" data-action="ajaxAnswerSave">															
												                <g:hiddenField id="answer-0" name="answer.id-0" value="0" />
												                <g:hiddenField id="answerOptionVersion-0" data-role="version" name="answer.version-0" value="" />
																<!--input type="text" id="question-0-answer-0" class="textAnswer" disabled="disabled" placeholder="Their answer" /-->
																<div class="multiHolder">
																	<g:hiddenField id="question-0-answerId-0" name="answer.id-0" value="0" />
													                <g:hiddenField id="answerOptionVersion-0" data-role="version" 
																	name="answer.version-0" value="" />
																	<input type="radio" name="question-0-answer" />
																	<input type="text" class="blurSave" id="question-0-answer-0" 
																	data-idInput="question-0-answerId-0" data-versionInput="answerOptionVersion-0" 
																	data-qTypeInput="qType-0" data-controller="answerOption" 
																	data-action="ajaxAnswerSave" data-questionIdInput="questionId-0" 
																	value="Option 1" />
																	
																	<div class="ajaxMessage"></div>
																	
																	<input type="text" class="associatedScore" id="associatedScore-0" 
																	data-controller="answerOption" data-versionInput="answerOptionVersion-0" 
																	data-action="ajaxAssociatedScoreUpdate" placeholder="0" />																	

																	<div class="ajaxMessage"></div>
																	
																	<a href="#" title="Delete answer" class="delete" data-controller="answerOption" data-action="ajaxDelete"></a>
																</div>
															</li>
														
															<li data-id="0" class="notSelectable">
																<div class="multiHolder">
															        <input type="hidden" id="question-1-answerId-1" name="answer.id-1" value="0" />
													                <input type="hidden" id="answerOptionVersion-1" data-role="version" 
																	name="answer.version-1" value="" />
																	
																	<input type="radio" name="question-0-answer" />
																	
																	<input type="text" class="blurSave" id="question-0-answer-1" 
																	data-idInput="question-1-answerId-1" data-versionInput="answerOptionVersion-1" 
																	data-qTypeInput="qType-0" data-controller="answerOption" 
																	data-action="ajaxAnswerSave" data-questionIdInput="questionId-0" 
																	value="Click to add option" />
																	
																	<div class="ajaxMessage"></div>
																	
																	<input type="text" class="associatedScore" id="associatedScore-1" 
																	data-controller="answerOption" data-versionInput="answerOptionVersion-1" 
																	data-action="ajaxAssociatedScoreUpdate" placeholder="0" />
																	

																	<div class="ajaxMessage"></div>
																	
																	<a href="#" title="Delete answer" class="delete" data-controller="answerOption" data-action="ajaxDelete"></a>
																</div>
															</li>
														
														</ul>
													</div>
													<div class="qSubmit">
														<button type="button" id="qDone-0" data-qInput="q-0" data-viewDiv="viewDiv-0" data-editDiv="editDiv-0" data-answerList="answerList-0" data-qTypeInput="qType-0" class="questionComplete">Done</button>
													</div>
												</div>
											
												<div class="qInputs" data-mode="view" id="viewDiv-0">
													<div id="qViewHolder-0" class="qViewHolder">
													
													</div>
													<a href="#" id="qEdit-0" data-viewDiv="viewDiv-0" data-editDiv="editDiv-0" class="questionEdit">Edit</a>
												</div>
											
											</li>
										
										</ul>
									
									
		<a href="#" class="addQuestion" id="addQuestion" title="Add new  question">Add Question</a>

		                                </td>
		                            </tr>
                        
                        
	                            <tr class="prop">
	                                <td class="name">
	                                    <label for="author"><g:message code="mediSurvey.author.label" default="Author" /></label>
	                                </td>
	                                <td class="value ${hasErrors(bean: mediSurveyInstance, field: 'author', 'errors')}">
	                                    <g:hiddenField id="authorID" name="author.id" value="${session.user.id}"  /> ${session.user}
	                                </td>
	                            </tr>
                        
	                        </tbody>
	                    </table>
	                </div>
	                <div class="buttons">
	                    <span class="button"><g:submitButton id="submitButton" name="create" class="save" value="Save" /></span>
	                </div>
	            </g:form>
			</div>
        </div>
    </body>
</html>
