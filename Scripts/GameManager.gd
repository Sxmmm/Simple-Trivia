extends Control

var api_url = "https://opentdb.com/api.php?amount=150"
var http_request: HTTPRequest


var question_UI: Control

func _ready():
	question_UI = $QuestionUI
	http_request = $HTTPRequest
	

func start_game():
	make_api_request()

func make_api_request():
	http_request.request(api_url)

func _on_http_request_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		if json["response_code"] == 0:
			process_questions(json["results"])
			start_questions()

func process_questions(results):
	for result in results:
		var new_question = Global.Question.new()
		new_question.type = result["type"]
		new_question.question = result["question"]
		new_question.correct_answer = result["correct_answer"]
		new_question.answers = result["incorrect_answers"]
		new_question.answers.append(result["correct_answer"])
	
		randomize()
		new_question.answers.shuffle()
		
		Global.add_question(new_question)
		
func start_questions():
	question_UI.display_question()
