package medisurv

class AnswerOptionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }
	
    def list = {
		println 'answerOption List Called'
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [answerOptionInstanceList: AnswerOption.list(params), answerOptionInstanceTotal: AnswerOption.count()]
    }

	def listByQuestion = {
		def answerOptionInstance = AnswerOption.list(params,sort:"sequence",order:"desc")
		println 'answerOptionInstance' + answerOptionInstance
	}
	
	def ajaxDeleteOldAnswerOption = {
		println 'questionID: ['+params.question.id+']'
		def questionInstance = Question.get(params.question.id)
		def answerOptionInstance = AnswerOption.findAllByQuestion(questionInstance)
		println ''
		println ''
		println '================================================='
		println 'ajaxDeleteOldAnswerOption answerOptionInstance size ['+answerOptionInstance.size()+']'
		println '================================================='
		if (answerOptionInstance.size() > 0)
		{
			for (i in answerOptionInstance)
			{
				println 'answer option id: ' + i
			
				if (i) {
		            try {
						println 'start ajaxDeleteOldAnswerOption'
		                i.delete(flush: true)
		                render(contentType: "text/json") {
							result(
								success: true,
					        	message: "Old AnswerOptions successfully deleted")
					    }
						println 'successful delete of Old AnswerOptions'
		            }
		            catch (org.springframework.dao.DataIntegrityViolationException e) {
						println 'Old AnswerOptions not deleted - Integrity Violation Exception'
		                render(contentType: "text/json") {
							result(
								success: false,
					        	message: "Old AnswerOptions not deleted")
					    }
		            }
		        }
		        else {
					println 'Old AnswerOption not found'
		            render(contentType: "text/json") {
						result(
							success: false,
				        	message: "Old AnswerOption not found")
				    }
		        }
			}			
		}
		else
		{
			println 'No answer options to delete'
            render(contentType: "text/json") {
				result(
					success: false,
		        	message: "No answer options to delete")
		    }
		}
	}

    def create = {
        def answerOptionInstance = new AnswerOption()
        answerOptionInstance.properties = params
        return [answerOptionInstance: answerOptionInstance]
    }

	def newRadio = {
		def answerOptionInstance = new AnswerOption()
        answerOptionInstance.properties = params
        return [answerOptionInstance: answerOptionInstance]
	}
	
	def ajaxDelete = {
		def answerOptionInstance = AnswerOption.get(params.id)
		println "answerOption delete initiated"
		println "answerOptionInstance :" + answerOptionInstance
		println "User agent: " + request.getHeader("User-Agent")
        if (answerOptionInstance) {
            try {
                answerOptionInstance.delete(flush: true)
                render(contentType: "text/json") {
					result(
						success: true,
			        	message: "AnswerOption successfully deleted")
			    }
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                render(contentType: "text/json") {
					result(
						success: false,
			        	message: "AnswerOption not deleted")
			    }
            }
        }
        else {
            render(contentType: "text/json") {
				result(
					success: false,
		        	message: "AnswerOption not found")
		    }
        }
	}
	
	def ajaxAnswerUpdate = {
		def answerOptionInstance = AnswerOption.get(params.id)
		println ''
		println ''
		println '================================================='
		println 'ajaxAnswer Update'
		println '================================================='
		println "answerOptionInstance: ["+answerOptionInstance+"]" 
        if (answerOptionInstance) {	
            if (params.version) {
                def version = params.version.toLong()
                if (answerOptionInstance.version > version) {
					println "collision issue"
                    render(contentType: "text/json") 
					{
						result(
						success: false,
				       	message: "Another user has updated this answer while you were editing")
				 	}
                }
            }
            answerOptionInstance.properties = params
            if (!answerOptionInstance.hasErrors() && answerOptionInstance.save(flush: true)) {
	
				println "answerOptionInstance update["+answerOptionInstance+"]"
				println "good answerOption update"
				println "version["+answerOptionInstance.version+"]"
                render(contentType: "text/json") {
					result(
						success: true,
						message: "Answer updated",
						version: answerOptionInstance.version)
			    }
            }
            else {
				println "unknown error"
                render(contentType: "text/json") {
					result(
						success: false,
				       	message: "Unknown error updating answer")
				 }
            }
        }
        else {
			println "retrieve record issue"
            render(contentType: "text/json") {
				result(
					success: false,
			       	message: "There was an error updating the answer - unable to get the record")
			 }
        }
	}
	
	def ajaxAnswerSave = {
		def answerOptionInstance = new AnswerOption(params)
		println ''
		println ''
		println '================================================='
		println 'ajaxAnswer Save'
		println '================================================='
		println "inputLabel: " + answerOptionInstance.inputLabel
		println "params: " + params
		println "answerOptionInstance pre save: " + answerOptionInstance
		println "Question ID: " + answerOptionInstance.question.id
		if (answerOptionInstance.question.id > 0)
		{
			def saveDetails = answerOptionInstance.save(flush: true)
			println "saveDetails (answerOptionInstance post save): " + saveDetails
			if (saveDetails) {	
				println "Good answer option save"
				println saveDetails.id
				println saveDetails.version		
	            render(contentType: "text/json") {
					result(
						success: true,
						message: "Answer Saved",
						newID: saveDetails.id,
						version: saveDetails.version)
			    }
	        }
	        else {
				println "===ISSUES!!====="
	             render(contentType: "text/json") {
					result(
						success: false,
				       	message: "error")
				 }
	        }
		}
		else
		{
			println "Question ID = 0 - You can't save an answer to a question that doesn't exist"
		}
	}

    def save = {
        def answerOptionInstance = new AnswerOption(params)
        if (answerOptionInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'answerOption.label', default: 'AnswerOption'), answerOptionInstance.id])}"
            redirect(action: "show", id: answerOptionInstance.id)
        }
        else {
            render(view: "create", model: [answerOptionInstance: answerOptionInstance])
        }
    }

    def show = {
        def answerOptionInstance = AnswerOption.get(params.id)
        if (!answerOptionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'answerOption.label', default: 'AnswerOption'), params.id])}"
            redirect(action: "list")
        }
        else {
            [answerOptionInstance: answerOptionInstance]
        }
    }

    def edit = {
        def answerOptionInstance = AnswerOption.get(params.id)
        if (!answerOptionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'answerOption.label', default: 'AnswerOption'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [answerOptionInstance: answerOptionInstance]
        }
    }

    def update = {
        def answerOptionInstance = AnswerOption.get(params.id)
        if (answerOptionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (answerOptionInstance.version > version) {
                    
                    answerOptionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'answerOption.label', default: 'AnswerOption')] as Object[], "Another user has updated this AnswerOption while you were editing")
                    render(view: "edit", model: [answerOptionInstance: answerOptionInstance])
                    return
                }
            }
            answerOptionInstance.properties = params
            if (!answerOptionInstance.hasErrors() && answerOptionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'answerOption.label', default: 'AnswerOption'), answerOptionInstance.id])}"
                redirect(action: "show", id: answerOptionInstance.id)
            }
            else {
                render(view: "edit", model: [answerOptionInstance: answerOptionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'answerOption.label', default: 'AnswerOption'), params.id])}"
            redirect(action: "list")
        }
    }

	def ajaxAssociatedScoreUpdate = {
		def answerOptionInstance = AnswerOption.get(params.id)
		println '******************************************'
		println 'answerOptionInstance.id: '+answerOptionInstance.id
		println 'answerOptionInstance.associatedScore: '+answerOptionInstance.associatedScore
		println 'answerOptionInstance.version: '+answerOptionInstance.version
		println 'answerOptionInstance: '+AnswerOption.get(params.id)
		println '******************************************'
		//def anwserOptionId = answerOptionInstance.id
		/*
		println '******************************************'
		println 'ajaxAssociatedScoreUpdate called'
		println 'answer option id: ' + anwserOptionId
		println 'associated score: ' + params.associatedScore
		println '******************************************'
		*/
		if (answerOptionInstance) {	
            if (params.version) {
                def version = params.version.toLong()
                if (answerOptionInstance.version > version) {
					println "collision issue during associated score update"
                    render(contentType: "text/json") 
					{
						result(
						success: false,
				       	message: "Another user has updated this AnswerOption - AssociatedScore while you were editing")
				 	}
                }
            }
            answerOptionInstance.properties = params
            if (!answerOptionInstance.hasErrors() && answerOptionInstance.save(flush: true)) {
	
				println "answerOptionInstance - AssociatedScore update["+answerOptionInstance+"]"
				println "good answerOption update"
				println "version["+answerOptionInstance.version+"]"
                render(contentType: "text/json") {
					result(
						success: true,
			        	message: "associates score updated",
						version: answerOptionInstance.version)
			    }
            }
            else {
				println "unknown error"
                render(contentType: "text/json") {
					result(
						success: false,
				       	message: "error")
				 }
            }
        }
        else {
			println "retrieve record issue"
            render(contentType: "text/json") {
				result(
					success: false,
			       	message: "There was an error updating the answerOption AssociatedScore - unable to get the record")
			 }
        }
	}

	def setSequence = {
		def answerOptionList = params.id	
		println answerOptionList	
		int x = 0
		Boolean goodSave = true
		if (answerOptionList.length > 0)
		{
			for (i in answerOptionList)
			{			
				def answerOption = AnswerOption.read(i)
				answerOption.sequence = x
				//.save() returns a boolean which we can use to check as to whether to break
				goodSave = answerOption.save()
				if(!goodSave)
				{
					println "error at: [" + i + "]and["+x+"]"
					break
				}
				x++
			}
						
			if (goodSave)
			{
				render(contentType: "text/json") {
					result(
						success: true,
			        	message: "answerOptions succesfully sorted")
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
        def answerOptionInstance = AnswerOption.get(params.id)
        if (answerOptionInstance) {
            try {
                answerOptionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'answerOption.label', default: 'AnswerOption'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'answerOption.label', default: 'AnswerOption'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'answerOption.label', default: 'AnswerOption'), params.id])}"
            redirect(action: "list")
        }
    }
}
