class_name CharacterSkin
extends Node3D

signal foot_step

@export var main_animation_player : AnimationPlayer

var moving_blend_path := "parameters/StateMachine/move/blend_position"

# False : set animation to "idle"
# True : set animation to "move"
@onready var moving : bool = false : set = set_moving

# Blend value between the walk and run cycle
# 0.0 walk - 1.0 run
@onready var move_speed : float = 0.0 : set = set_moving_speed
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")


func _ready():
	animation_tree.active = true
	main_animation_player["playback_default_blend_time"] = 0.1


func set_moving(value : bool):
	moving = value
	if moving:
		main_animation_player.play("Walk_01")
		#state_machine.travel("move")
	else:
		main_animation_player.play("_Default")
		#state_machine.travel("idle")


func set_moving_speed(value : float):
	move_speed = clamp(value, 0.0, 1.0)
	animation_tree.set(moving_blend_path, move_speed)


func jump():
	main_animation_player.play("Jump")
	#state_machine.travel("jump")

func get_damaged():
	main_animation_player.play("Get_Hit")
	
func fall():
	pass
	#main_animation_player.play("Fall_Landing")
	#state_machine.travel("fall")


func punch():
	animation_tree["parameters/PunchOneShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE

