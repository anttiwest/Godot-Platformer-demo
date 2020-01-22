extends Node

func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/PlayButton.grab_focus()
	

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/PlayButton.is_hovered():
		$MarginContainer/VBoxContainer/VBoxContainer/PlayButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/QuitButton.is_hovered():
		$MarginContainer/VBoxContainer/VBoxContainer/QuitButton.grab_focus()

func _on_PlayButton_pressed():
	# Change scenes
	get_tree().change_scene("Stage1.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
