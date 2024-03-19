extends Control

var game_screen: Control

func _ready():
	game_screen = $"../GameScreen"
	self.visible = true
	game_screen.visible = false

func _on_button_start_button_down():
	game_screen.start_game()
	game_screen.visible = true
	self.visible = false
