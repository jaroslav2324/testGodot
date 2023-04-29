extends RigidBody2D

var anger = 0
@export var monsterSpeed = 100
func _ready():
	self.position.x = -400
	self.position.y = 100
	$monster/TimerAnger.start()

func _process(delta):
	self.linear_velocity = Vector2(monsterSpeed,0)
	$monster/AnimatedSprite2D.play("fly")
	
	if anger == 3:
		get_tree().paused = true
	


func _on_timer_anger_timeout():
	anger = anger - 1
