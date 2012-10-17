

<%@ page import="medisurv.MediSurvey"
page import="medisurv.AnswerOption" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mediSurvey.label', default: 'MediSurvey')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <!--div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div-->
        <div class="body">
			<div class="contentArea">
            	<h1><!--g:message code="default.edit.label" args="[entityName]" /--></h1>
	            <g:if test="${flash.message}">
	            <div class="message">${flash.message}</div>
	            </g:if>
	            <g:hasErrors bean="${mediSurveyInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${mediSurveyInstance}" as="list" />
	            </div>
	            </g:hasErrors>
	            <g:form id="frmEditSurvey" method="post" >
                
	                <div class="dialog">
	                    <table class="surveyFields">
	                        <tbody>
                        
	                            <tr class="prop">
	                                <td class="name">
	                                  <label for="title"><g:message code="mediSurvey.title.label" default="Title" /></label>
	                                </td>
	                                <td class="value ${hasErrors(bean: mediSurveyInstance, field: 'title', 'errors')}">
	                                    <g:hiddenField name="id" value="${mediSurveyInstance?.id}" />
						                <g:hiddenField name="version" value="${mediSurveyInstance?.version}" />
	                                    <g:textField id="title" name="title" value="${mediSurveyInstance?.title}" data-controller="mediSurvey" data-action="ajaxSurveyUpdate" /><div class="ajaxMessage"></div>
	                                </td>
	                            </tr>
                        
	                            <tr class="prop">
	                                <td class="name">
	                                  <label for="status"><g:message code="mediSurvey.status.label" default="Status" /></label>
	                                </td>
	                                <td class="value ${hasErrors(bean: mediSurveyInstance, field: 'status', 'errors')}">
	                                    <g:select name="status" from="${mediSurveyInstance.constraints.status.inList}" value="${mediSurveyInstance?.status}" valueMessagePrefix="mediSurvey.status"  />
	                                </td>
	                            </tr>
                        
	                            <tr class="prop">
	                                <td class="name">
	                                  <label for="author"><g:message code="mediSurvey.author.label" default="Author" /></label>
	                                </td>
	                                <td class="value ${hasErrors(bean: mediSurveyInstance, field: 'author', 'errors')}">
	                                    <g:select name="author.id" from="${medisurv.User.list()}" optionKey="id" value="${mediSurveyInstance?.author?.id}"  />
	                                </td>
	                            </tr>
                        
	                            <tr class="prop">
	                                <td class="name label">
	                                  <label for="questions"><g:message code="mediSurvey.questions.label" default="Questions" /></label>
	                                </td>
	                                <td class="questions ${hasErrors(bean: mediSurveyInstance, field: 'questions', 'errors')}">
	                               		<ul id="questionList" class="buttonList sortable" data-controller="question" data-action="setSequence">	
									
										<g:each in="${mediSurveyInstance?.questions?}" status="i" var="q">
										
									    	<li data-id="${q?.id}">
												<div style="display:none;" class="qEditHolder" data-holderId="${i}" data-mode="edit" id="editDiv-${i}">
													<div class="q">
										                <g:hiddenField id="questionId-${i}" name="question.id-${i}" value="${q?.id}" />
										                <g:hiddenField id="questionVersion-${i}" data-role="version" name="question.version-${i}" value="${q?.version}" />
														<label for="q-${i}">Question</label>
														<g:textField value="${q?.question}" id="q-${i}" name="q-${i}" class="question" data-idInput="questionId-${i}" data-versionInput="questionVersion-${i}" data-qTypeInput="qType-${i}" data-controller="question" data-action="ajaxQuestionUpdate" /><div class="ajaxMessage"></div>
													</div>
													<div class="qType">
														<label for="qType-${i}">Question Type</label>										
														<g:select id="qType-${i}" class="qType" name="questionType-${i}" data-qInput="q-${i}" data-multipleAnswers="${(q?.questionType?.toLowerCase() == 'text' ? false : true)}" from="${q.constraints.questionType.inList}" value="${q?.questionType}" valueMessagePrefix="q.questionType" />
													</div>
												
													<div class="qAnswers">
														<ul id="answerList-${i}" data-controller="answerOption" data-action="setSequence">
														
															<g:if test="${q?.questionType?.toLowerCase() == 'text'}">
																<li>
																<input type="text" id="question-${i}-answer-${j}" class="textAnswer" disabled="disabled" placeholder="Their answer" />
																</li>
															</g:if>
															
															<g:each in="${q?.answerOptions?}" status="j" var="a">
																<li data-id="${a.id}">
													                <g:hiddenField id="question-${i}-answerId-${j}" name="answer.id-${j}" value="${a.id}" />
													                <g:hiddenField id="answerOptionVersion-${j}" data-role="version" name="answer.version-0" value="${a.version}" />
																	<g:if test="${q?.questionType?.toLowerCase() == 'radio'}">
																		<input type="radio" name="question-${i}-answer" />
																		<input type="text" 
																		class="blurSave" 
																		data-idInput="question-${i}-answerId-${j}" 
																		data-versionInput="answerOptionVersion-${j}" 
																		data-qTypeInput="qType-${i}" 
																		data-controller="answerOption" 
																		data-action="ajaxAnswerUpdate" 
																		data-questionIdInput="questionId-${i}" 
																		id="question-${i}-answer-${j}" 
																		value="${a?.inputLabel}" />
																		
																		<div class="ajaxMessage"></div>
																		
																		<input type="text" 
																		class="associatedScore" 
																		data-controller="answerOption" 
																		data-versionInput="answerOptionVersion-${j}"
																		data-action="ajaxAssociatedScoreUpdate" 
																		id="associated-Score-${j}" 
																		placeholder="0" value="${a.associatedScore}" />

																		<div class="ajaxMessage"></div>
																	</g:if>
																
																	<g:if test="${q?.questionType?.toLowerCase() == 'checkbox'}">
																		<input type="checkbox" name="question-${i}-answer" />
																		<input type="text" 
																		class="blurSave" 
																		data-idInput="question-${i}-answerId-${j}" 
																		data-versionInput="answerOptionVersion-${j}" 
																		data-qTypeInput="qType-${i}" 
																		data-controller="answerOption" 
																		data-action="ajaxAnswerUpdate" 
																		data-questionIdInput="questionId-${i}" 
																		id="question-${i}-answer-${j}" 
																		value="${a?.inputLabel}" />
																		
																		<div class="ajaxMessage"></div>
																		
																		<input type="text" 
																		class="associatedScore" 
																		data-controller="answerOption" 
																		data-versionInput="answerOptionVersion-${j}"
																		data-action="ajaxAssociatedScoreUpdate"  
																		id="associated-Score-${j}" 
																		placeholder="0" value="${a.associatedScore}" />

																		<div class="ajaxMessage"></div>
																		
																	</g:if>
																	
																	<g:if test="${q?.questionType.toLowerCase() == 'select'}">
																		
																		<input type="text" 
																		class="blurSave" 
																		data-idInput="question-${i}-answerId-${j}" 
																		data-versionInput="answerOptionVersion-${j}" 
																		data-qTypeInput="qType-${i}" 
																		data-controller="answerOption" 
																		data-action="ajaxAnswerUpdate" 
																		data-questionIdInput="questionId-${i}" 
																		id="question-${i}-answer-${j}" 
																		value="${a?.inputLabel}" />
																		
																		<div class="ajaxMessage"></div>
																		
																		<input type="text" 
																		class="associatedScore" 
																		data-controller="answerOption" 
																		data-versionInput="answerOptionVersion-${j}"
																		data-action="ajaxAssociatedScoreUpdate"  
																		id="associated-Score-${j}" 
																		placeholder="0" value="${a.associatedScore}" />

																		<div class="ajaxMessage"></div>
																	</g:if>
																	
																	<a href="#" class="delete" data-controller="answerOption" data-action="ajaxDelete" title="Delete this answer"></a>
																
																</li>
													
															
																<g:if test="${(q?.answerOptions?.size() - 1) == j && (q?.questionType?.toLowerCase() == 'checkbox' || q?.questionType?.toLowerCase() == 'radio' || q?.questionType?.toLowerCase() == 'select')}">
																	<li data-id="0" class="notSelectable">
																		<div class="multiHolder">
																	    	<input type="hidden" id="question-${i}-answerId-${j+1}" name="answer.id-${j+1}" value="0">
																		    <input type="hidden" id="answerOptionVersion-${j+1}" data-role="version" name="answer.version-${j+1}" value="">			
																			<g:if test="${q?.questionType?.toLowerCase() == 'checkbox' || q?.questionType?.toLowerCase() == 'radio'}">
																				<input type="${q?.questionType?.toLowerCase()}" name="question-${i}-answer">
																			</g:if>
																			<input type="text" class="blurSave" id="question-${i}-answer-${j+1}" data-idInput="question-${i}-answerId-${j+1}" data-versionInput="answerOptionVersion-${j+1}" data-qTypeInput="qType-${i}" data-controller="answerOption" data-action="ajaxAnswerSave" data-questionIdInput="questionId-${i}" value="Click to add option" />
																			
																			<div class="ajaxMessage"></div>
																			
																			<input type="text" 
																			class="associatedScore" 
																			data-controller="answerOption" 
																			data-versionInput="answerOptionVersion-${j+1}"
																			data-action="ajaxAssociatedScoreUpdate"  
																			id="associated-Score-${j+1}" 
																			placeholder="0" />

																			<div class="ajaxMessage"></div>
																			
																			<a href="#" class="delete" data-controller="answerOption" data-action="ajaxDelete" title="Delete this answer"></a>
																		</div>
																	</li>																
																</g:if>
																
															
															</g:each>
															
															
														</ul>
													</div>

														<div class="qSubmit">
															<button type="button" id="qDone-${i}" data-qInput="q-${i}" data-viewDiv="viewDiv-${i}" data-editDiv="editDiv-${i}" data-answerList="answerList-${i}" data-qTypeInput="qType-${i}" class="questionComplete">Done</button>
														</div>
												</div>
											
												<div style="display:block;" class="qInputs" data-mode="view" id="viewDiv-${i}">
													<div id="qViewHolder-${i}" class="qViewHolder">
														<label class="question">${q?.question}</label>
														
														<a href="#" class="delete" data-controller="question" data-action="ajaxDelete" title="Delete this question"></a>
													
														<ul class="viewOptions">
															<g:if test="${q?.questionType?.toLowerCase() == 'select'}">
																<li class="notSelectable">
																	<select id="questionSelect-${q.id}">
															</g:if>
															<g:each in="${q?.answerOptions?}" status="j" var="a">
																<g:if test="{q?.questionType?.toLowerCase() == 'select'}">
																	<option value="">${a?.inputLabel}</option>
																</g:if>
																
																<g:if test="${q?.questionType?.toLowerCase() == 'checkbox' || q?.questionType?.toLowerCase() == 'radio'}">															
																	<li class="notSelectable">
																		<input type="${q?.questionType?.toLowerCase()}" id="multi-question-${i}-answer-${j}" name="question-${i}-answer"><label for="multi-question-${i}-answer-${j}">${a?.inputLabel}</label>
																	</li>
																</g:if>
															</g:each>
															<g:if test="${q?.questionType?.toLowerCase() == 'select'}">
																	</select>
																</li>
															</g:if>
														
															<g:if test="${q?.questionType?.toLowerCase() == 'text'}">
																<li class="notSelectable">
																	<input type="text" class="textAnswer" disabled="disabled" placeholder="Their answer" />
																</li>
															</g:if>
															
															<g:if test="${q?.questionType?.toLowerCase() == 'textarea'}">
																<li class="notSelectable">
																	<textarea disabled="disabled" placeholder="Their answer"></textarea>
																</li>
															</g:if>
														</ul>
													
													</div>
													<a href="#" id="qEdit-${i}" data-viewDiv="viewDiv-${i}" data-editDiv="editDiv-${i}" class="questionEdit" title="Edit question">Edit</a>
												</div>
											</li>
										</g:each>
												
									</ul>
								
									<a href="#" class="addQuestion" id="addQuestion" title="Add new  question">Add Question</a>

	                                </td>
	                            </tr>
                        
	                        </tbody>
	                    </table>
	                </div>
	                <div class="buttons">
	                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
	                </div>
	            </g:form>
			</div>
        </div>
    </body>
</html>
