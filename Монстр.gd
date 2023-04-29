extends RigidBody2D
var anger = 0
var maxAnger = 5
var hit_bit = true
@export var monsterSpeed = 100


func _ready():
	self.position.x = -400
	self.position.y = 100
	$monster/TimerAnger.start()
	$monster/TimerPlavnikov.start()
	$monster/plovnik.play()

func _process(delta):
	self.linear_velocity = Vector2(monsterSpeed,0)
	$monster/AnimatedSprite2D.play("fly")
	$monster/Label.text = "hit bit:" + str(hit_bit) + " anger:" + str(anger)
	if anger >= maxAnger:
		get_tree().paused = true


func _on__stroke_on_water():
	print_debug("anger", anger)
	if !hit_bit:
		anger += 1



func _on_timer_plavnikov_timeout():
	print_debug("aaaaa")
	if hit_bit:
		hit_bit = false
	else:
		$monster/plovnik.play()
		hit_bit = true
	



func _on_timer_anger_timeout():
	if anger > 0: anger -= 1
