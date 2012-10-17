import medisurv.*
class BootStrap {

    def init = { servletContext -> 
		def patient = new User(firstName: 'John' ,
		lastName: 'Smith' ,
		userName: 'johnsmith1' ,
		password: 'password1' ,
		userCode: '123456',
		role: 'Patient',
		status:'Active')
		
		if (!patient.save()){
			patient.errors.allErrors.each{error ->
				println "An error occured with patient: ${error}"
			}
		}
		
		def doctor1 = new User(firstName: 'Jane' ,
		lastName: 'Jones' ,
		userName: 'janejones1' ,
		password: 'password1' ,
		userCode: '123456',
		role: 'Doctor',
		status:'Active')
		
		if (!doctor1.save()){
			doctor1.errors.allErrors.each{error ->
				println "An error occured with doctor: ${error}"
			}
		}
		
		def doctor2 = new User(firstName: 'Jason' ,
		lastName: 'Taikato' ,
		userName: 'jason' ,
		password: 'splat3' ,
		userCode: '654321',
		role: 'Doctor',
		status:'Active')
		
		if (!doctor2.save()){
			doctor2.errors.allErrors.each{error ->
				println "An error occured with doctor: ${error}"
			}
		}
		
				
		def admin = new User(firstName: 'Paul' ,
		lastName: 'Doe' ,
		userName: 'pauldoe1' ,
		password: 'password1' ,
		userCode: '123456',
		role: 'Admin',
		status:'Active')
		
		if (!admin.save()){
			admin.errors.allErrors.each{error ->
				println "An error occured with admin: ${error}"
			}
		}
		
		
		def survey1 = new MediSurvey(title: 'Test Survey 1',
		dateCreated: new Date(),
		status: 'Active',
		author: User.findByUserName('pauldoe1')).save()
		
		def question1 = new Question(question: 'Test Question 1',
		survey: survey1,
		sequence: 0).save()
		
		def question2 = new Question(question: 'Test Question 2',
		survey: survey1,
		sequence: 1).save()
		
		def question3 = new Question(question: 'Test Question 3',
		survey: survey1,
		sequence: 2).save()
		
		def question4 = new Question(question: 'Test Question 4',
		survey: survey1,
		sequence: 3).save()
		
		def answerOption1 = new AnswerOption(inputType:'checkbox',
		inputLabel:'Answer option 1 label',
		question: question1,
		sequence: 0,
		associatedScore: 3).save()
		
		def answerOption2 = new AnswerOption(inputType:'checkbox',
		inputLabel:'Answer option 2 label',
		question: question1,
		sequence: 1,
		associatedScore: 3).save()
		
		def answerOption3 = new AnswerOption(inputType:'checkbox',
		inputLabel:'Answer option 3 label',
		question: question1,
		sequence: 2,
		associatedScore: 3).save()
		
		def answerOption4 = new AnswerOption(inputType:'checkbox',
		inputLabel:'Answer option 4 label',
		question: question1,
		sequence: 3,
		associatedScore: 3).save()
				
	}

    def destroy = {
    }
}
