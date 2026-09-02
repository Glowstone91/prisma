extends CharacterBody2D

@onready var animacao = $animacao

const VELOCIDADE = 100.0
const GRAVIDADE = 800.0
const FORCA_PULO = -350.0


func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVIDADE * delta

	# Movimento para esquerda/direita
	var direcao = Input.get_axis("move_left", "move_right")
	velocity.x = direcao * VELOCIDADE

	# Virar a Prisma
	if direcao < 0:
		animacao.flip_h = true
	elif direcao > 0:
		animacao.flip_h = false

	# Pulo
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = FORCA_PULO

	# Animações
	if not is_on_floor():
		animacao.play("jump")
	elif direcao != 0:
		animacao.play("walking")
	else:
		animacao.play("idle")

	# Aplica o movimento
	move_and_slide()
