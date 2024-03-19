extends Control

var btn_a: Button
var btn_b: Button
var btn_c: Button
var btn_d: Button
var btn_a_label: Label
var btn_b_label: Label
var btn_c_label: Label
var btn_d_label: Label
var q_label: Label
var score_label: Label

var correct_answer: String
var answer_given: String

var game_screen: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	q_label = $QuestionLabel
	score_label = $ScoreLabel
	btn_a_label = $ButtonA/Label
	btn_b_label = $ButtonB/Label
	btn_c_label = $ButtonC/Label
	btn_d_label = $ButtonD/Label
	btn_a = $ButtonA
	btn_b = $ButtonB
	btn_c = $ButtonC
	btn_d = $ButtonD
	
	game_screen = $".."
	
	q_label.visible = false
	btn_a.visible = false
	btn_b.visible = false
	btn_c.visible = false
	btn_d.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_question():
	var question = Global.get_current_question()
	check_load_more_questions()
	q_label.text = unescape_text(question.question.xml_unescape())
	q_label.visible = true
	correct_answer =  unescape_text(question.correct_answer.xml_unescape())
	
	if (question.type == "multiple"):
		btn_a.visible = true
		btn_a_label.text =  unescape_text(question.answers[0].xml_unescape())
		btn_b.visible = true
		btn_b_label.text =  unescape_text(question.answers[1].xml_unescape())
		btn_c.visible = true
		btn_c_label.text =  unescape_text(question.answers[2].xml_unescape())
		btn_d.visible = true
		btn_d_label.text =  unescape_text(question.answers[3].xml_unescape())
	else:
		btn_a.visible = true
		btn_a_label.text =  unescape_text(question.answers[0].xml_unescape())
		btn_b.visible = false
		btn_c.visible = true
		btn_c_label.text =  unescape_text(question.answers[1].xml_unescape())
		btn_d.visible = false

func unescape_text(text):
	text = text.replace("&eacute;", "é")
	text = text.replace("&#039;", "'")
	text = text.replace("&quot;", "\"")
	text = text.replace("&lt;", "<")
	text = text.replace("&gt;", ">")
	text = text.replace("&amp;", "&")
	text = text.replace("&uuml;", "ü")
	text = text.replace("&oacute;", "ó")
	# Add more replacements as needed
	return text

func _on_button_a_button_down():
	answer_given = btn_a_label.text
	check_answer()

func _on_button_b_button_down():
	answer_given = btn_b_label.text
	check_answer()

func _on_button_c_button_down():
	answer_given = btn_c_label.text
	check_answer()

func _on_button_d_button_down():
	answer_given = btn_d_label.text
	check_answer()

func check_answer():
	if answer_given == correct_answer:
		Global.increase_score()
		score_label.text = str(Global.score)
		display_question()
		
func should_load_more_questions():
	return Global.question_index == Global.questions.size() - 2
	
func check_load_more_questions():
	if should_load_more_questions():
		game_screen.make_api_request()
