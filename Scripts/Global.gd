# Global.gd

extends Node

# Define a custom structure for a question
class Question:
	var type: String
	var question: String
	var correct_answer: String
	var answers: Array

# Singleton instance
var instance

# Global variables
var questions: Array = []
var question_index: int
var score: int = 0

var game_screen: Control

func _ready():
	instance = self
	game_screen = $"../GameScreen"

func add_question(new_question):
	questions.append(new_question)

func get_current_question():
	return questions[question_index]

func increase_score():
	score += 1
	question_index += 1
