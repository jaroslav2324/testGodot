extends RigidBody2D

@export var monsterSpeed = 100
func _ready():
	self.position.x = -400
	self.position.y = 100

func _process(delta):
	self.linear_velocity = Vector2(monsterSpeed,0)
	$monster/AnimatedSprite2D.play("fly")
	
	
