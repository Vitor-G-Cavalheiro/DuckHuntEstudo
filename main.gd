extends Node2D

var patosnatela
var pato = preload("res://pato.tscn")
var voou = 0
var capturados = 0

func _ready():
	$GeraPato.start()

func _process(delta):
	$HUD/Label.text = str(capturados)
	$Alvo.position.x = get_local_mouse_position().x
	$Alvo.position.y = get_local_mouse_position().y

func nasce():
	var novop = pato.instantiate()
	add_child(novop)
	novop.position.x = randf_range(50,700)
	novop.position.y = 700

func _on_gera_pato_timeout():
	patosnatela = randi_range(1, 6)
	for n in patosnatela:
		nasce()

func _on_espera_timeout():
	$NovoTurno.play()
	$GeraPato.start()

func _on_topo_body_entered(body):
	voou = 1
	patosnatela -= 1
	$Voou.play()
	atualizaturno()

func _on_chao_body_entered(body):
	capturados += 1
	patosnatela -= 1
	$Colidiu.play()
	atualizaturno()

func atualizaturno():
	if(patosnatela == 0):
		$Espera.start()
		if voou == 1:
			$Cao.play("rindo")
			$CaoRindo.play()
			voou = 0
			capturados = 0
		else:
			$Cao.play("captura")
			$CaoCaptura.play()
