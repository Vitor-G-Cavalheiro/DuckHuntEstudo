extends CharacterBody2D

var side = 1
var vel = Vector2()
var spd = 100
var fall = 1

func _ready():
	$Quack.wait_time = randf_range(0.8, 2)
	randomize()
	$Movimento.wait_time = randf_range(0.4, 2)
	$Anima.wait_time = randf_range(0.6, 1)

func _process(delta):
	# movimentação horizontal
	position.x += spd*side*delta
	
	# movimentação vertical
	position.y -= 140*fall*delta
	
	# espelhamento da animação
	if side < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func _on_movimento_timeout() -> void:
	side = side*(-1)

func _on_anima_timeout() -> void:
	if $AnimatedSprite2D.animation == "cima":
		$AnimatedSprite2D.animation = "lado"
	elif $AnimatedSprite2D.animation == "lado":
		$AnimatedSprite2D.animation = "cima"

func mata():
	$AnimatedSprite2D.animation = "susto"
	$Morte.start()

func _on_morte_timeout():
	$Quack.stop()
	$AnimatedSprite2D.animation = "morte"
	fall = -1
	side = 0


func _on_quack_timeout():
	$Audio.play()
