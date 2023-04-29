extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerPosX = get_node("Игрок").position.x
	var monsterPosX = get_node("Монстр").position.x
	
		
