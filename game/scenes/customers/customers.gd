extends Node
class_name CustomerManager

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var body_sprite: Sprite2D = $body
@onready var head_sprite: Sprite2D = $body/head
@onready var dialogue_player: DialoguePlayer = %DialoguePlayer

var customer_bodies: Array[Texture2D] = [
	preload("res://sprites/concept/customer/0.png"),
	preload("res://sprites/concept/customer/1.png"),
	preload("res://sprites/concept/customer/2.png"),
	preload("res://sprites/concept/customer/3.png")
]
var customer_heads: Array[Texture2D] = [
	preload("res://sprites/concept/customer/0_head.png"),
	preload("res://sprites/concept/customer/1_head.png"),
	preload("res://sprites/concept/customer/2_head.png"),
	preload("res://sprites/concept/customer/3_head.png")
]

func _ready():
	body_sprite.position.x = -1600
	SignalBus.connect("progress_dialogue", on_progress_dialogue)

func set_customer_sprite(id: int):
	body_sprite.set_texture(customer_bodies[id])
	head_sprite.set_texture(customer_heads[id])	
	
func enter():
	animation_player.play("enter")

func leave():
	animation_player.play("leave")
	
func talk():
	animation_player.play("talk")

func start_talking():
	dialogue_player.start_dialogue()
	talk()

func on_progress_dialogue():
	if dialogue_player.is_in_progress():
		var success = dialogue_player.next_line()
		if success:
			talk()
