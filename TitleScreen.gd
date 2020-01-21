extends Node

var playButton
var quitButton

func _ready():
	$MarginContainer/VBoxContainer/HBoxContainer/PlayButton.grab_focus()
	

func _physics_process(delta):
	pass

func _on_PlayButton_pressed():
	# Change scenes
	get_tree().change_scene("Stage1.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
