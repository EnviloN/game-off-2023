extends Node
class_name CustomerManager

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var body_sprite: Sprite2D = $body
@onready var head_sprite: Sprite2D = $body/head
@onready var dialogue_player: DialoguePlayer = %DialoguePlayer

var customer_bodies: Array[Texture2D] = [
	preload("res://sprites/customers/0/0.PNG"),
	preload("res://sprites/customers/1/1.PNG"),
	preload("res://sprites/customers/2/2.PNG"),
	preload("res://sprites/customers/3/3.PNG"),
	preload("res://sprites/customers/4/4.PNG"),
	preload("res://sprites/customers/5/5.PNG"),
	preload("res://sprites/customers/6/6.PNG")
]
var customer_heads: Array[Texture2D] = [
	preload("res://sprites/customers/0/0_head.PNG"),
	preload("res://sprites/customers/1/1_head.PNG"),
	preload("res://sprites/customers/2/2_head.PNG"),
	preload("res://sprites/customers/3/3_head.PNG"),
	preload("res://sprites/customers/4/4_head.PNG"),
	preload("res://sprites/customers/5/5_head.PNG"),
	preload("res://sprites/customers/6/6_head.PNG")
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
