extends Node2D

var enemy_count = 1

func _ready():
	enemy_count = $Enemies.get_child_count()

func _physics_process(delta):
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene("TitleScreen.tscn")
		
	if $Enemies.get_child_count() == 0:
		get_tree().change_scene("TitleScreen.tscn")
	
