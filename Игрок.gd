extends Node2D

@export var max_velocity = 220
@export var back_acceleration = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position.x = 200
	self.position.y = 300
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("stroke"):
		
		var vel_x = self.linear_velocity.x + 100
		if vel_x > max_velocity:
			vel_x = max_velocity
		self.linear_velocity = Vector2(vel_x, 0)
	
	# back acceleration
	if self.linear_velocity.x < 0:
		self.linear_velocity.x = 0
	elif self.linear_velocity.x > 0:
		self.linear_velocity.x -= back_acceleration
