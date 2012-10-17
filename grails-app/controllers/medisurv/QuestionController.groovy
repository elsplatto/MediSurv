package medisurv

import grails.converters.JSON

class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		println 'question List Called'
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [questionInstanceList: Question.list(params), questionInstanceTotal: Question.count()]
    }

    def create = {
        def questionInstance = new Question()
        questionInstance.properties = params
        return [questionInstance: questionInstance]
    }

	def newQuestion = {
		def questionInstance = new Question()
        questionInstance.properties = params
        return [questionInstance: questionInstance]
	}

    def save = {
        def questionInstance = new Question(params)
		print questionInstance
        if (questionInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])}"
            redirect(action: "show", id: questionInstance.id)
        }
        else {
            render(view: "create", model: [questionInstance: questionInstance])
        }
    }

	def ajaxQuestionSave = {
		def questionInstance = new Question(params)
		println 'questionInstance for ajaxQuestionSave: ' + questionInstance
		def saveDetails = questionInstance.save(flush: true)
		if (saveDetails) {	
			println "Good question save"
			println saveDetails.id
			println saveDetails.version
            render(contentType: "text/json") {
				result(
					success: true,
		        	message: "Question successfully saved",
					newID: saveDetails.id,
					version: saveDetails.version)
		    }
        }
        else {
             render(contentType: "text/json") {
				result(
					success: false,
			       	message: "There was an error saving the question")
			 }
        }
	}

    def show = {
		println 'question Show called'
        def questionInstance = Question.get(params.id)
        if (!questionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])}"
            redirect(action: "list")
        }
        else {
            [questionInstance: questionInstance]
        }
    }

    def edit = {
		println 'question Edit Called'
        def questionInstance = Question.get(params.id)
        if (!questionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [questionInstance: questionInstance]
        }
    }

    def update = {
        def questionInstance = Question.get(params.id)
        if (questionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (questionInstance.version > version) {
                    
                    questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'question.label', default: 'Question')] as Object[], "Another user has updated this Question while you were editing")
                    render(view: "edit", model: [questionInstance: questionInstance])
                    return
                }
            }
            questionInstance.properties = params
            if (!questionInstance.hasErrors() && questionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])}"
                redirect(action: "show", id: questionInstance.id)
            }
            else {
                render(view: "edit", model: [questionInstance: questionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])}"
            redirect(action: "list")
        }
    }

	
	
	def ajaxDelete = {
		def questionInstance = Question.get(params.id)
		println "Question delete initiated"
		println "questionInstance :" + questionInstance
		println "User agent: " + request.getHeader("User-Agent")
        if (questionInstance) {
            try {
                questionInstance.delete(flush: true)
                render(contentType: "text/json") {
					result(
						success: true,
			        	message: "question successfully deleted")
			    }
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                render(contentType: "text/json") {
					result(
						success: false,
			        	message: "question not deleted")
			    }
            }
        }
        else {
            render(contentType: "text/json") {
				result(
					success: false,
		        	message: "question not found")
		    }
        }
	}
	
	
	def ajaxQuestionUpdate = {
		def questionInstance = Question.get(params.id)
        if (questionInstance) {
			'questionInstance for ajaxQuestionUpdate: ' + questionInstance.questionType
            if (params.version) {
                def version = params.version.toLong()
                if (questionInstance.version > version) {
					println "collision issue"
                    render(contentType: "text/json") 
					{
						result(
						success: false,
				       	message: "Another user has updated this Question while you were editing")
				 	}
                }
            }
            questionInstance.properties = params
            if (!questionInstance.hasErrors() && questionInstance.save(flush: true)) {
	
				println "questionInstance update["+questionInstance+"]"
				println "good question update"
				println "version["+questionInstance.version+"]"
                render(contentType: "text/json") {
					result(
						success: true,
			        	message: "Question successfully updated",
						version: questionInstance.version)
			    }
            }
            else {
				println "unknown error"
                render(contentType: "text/json") {
					result(
						success: false,
				       	message: "There was an error updating the question")
				 }
            }
        }
        else {
			println "retrieve record issue"
            render(contentType: "text/json") {
				result(
					success: false,
			       	message: "There was an error updating the question - unable to get the record")
			 }
        }
	}

	def setSequence = {
		def questionList = params.id
		println questionList			
		int x = 0
		Boolean goodSave = true
		if (questionList.length > 0)
		{
			for (i in questionList)
			{			
				def question = Question.read(i)
				question.sequence = x
				//.save() returns a boolean which we can use to check as to whether to break
				goodSave = question.save()
				if(!goodSave)
				{
					break
				}
				x++
			}
						
			if (goodSave)
			{
				render(contentType: "text/json") {
					result(
						success: true,
			        	message: "Questions succesfully sorted")
			    }
				
			}else{	
				render(contentType: "text/json") {
					result(
						success: false,
			            message: "Error occured during sort")
			       }
				
			}
			
		}	
	}

    def delete = {
        def questionInstance = Question.get(params.id)
        if (questionInstance) {
            try {
                questionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'question.label', default: 'Question'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])}"
            redirect(action: "list")
        }
    }
}
