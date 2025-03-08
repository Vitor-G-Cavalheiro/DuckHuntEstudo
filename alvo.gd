extends Area2D

var patoatual

func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body):
	patoatual = body

func _input(_event):
	if Input.is_action_just_pressed("Atirar"):
		$AudioStreamPlayer2D.play()
		if patoatual == null:
			print("Sem pato")
		else:
			patoatual.mata()
