package medisurv

class Question {
	String question
	String questionType
	MediSurvey survey
	int sequence
	
	String toString() {
		"$question"
	}
	
	static mapping = {
	    answerOptions sort: 'sequence', order: 'asc'
	}
	
	static hasMany = [answerOptions:AnswerOption]
	static belongsTo = MediSurvey
	
    static constraints = {
		question(blank:false,maxSize:1000)
		questionType(nullable:true,inList:["Radio","Checkbox","Text","Select","Textarea"])
		sequence(min:0)
    }

	
}
