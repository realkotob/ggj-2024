extends Node

enum INSTRUCTION_TYPES {KEYBOARD, JOYPAD}

@onready var demo_page_root: Control = $CanvasLayer/DemoPageRoot
@onready var resume_button: TextureButton = $CanvasLayer/DemoPageRoot/Content/MarginContainer/Buttons/Resume
@onready var exit_button: TextureButton = $CanvasLayer/DemoPageRoot/Content/MarginContainer/Buttons/Exit
@onready var keyboard_button: Button = %KeyboardButton
@onready var joypad_button: Button = %JoypadButton
@onready var grid_container_keyboard: GridContainer = %GridContainerKeyboard
@onready var grid_container_joypad: GridContainer = %GridContainerJoypad

@onready var _demo_mouse_mode: int


func _ready() -> void:
	get_tree().paused = true
	_demo_mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	
	exit_button.pressed.connect(get_tree().quit)




func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not event.is_echo():
		if get_tree().paused:
			resume_demo()
		else:
			pause_demo()


func change_instruction(type: int) -> void:
	match type:
		INSTRUCTION_TYPES.KEYBOARD:
			keyboard_button.modulate.a = 1.0
			joypad_button.modulate.a = 0.3
			grid_container_keyboard.show()
			grid_container_joypad.hide()
		INSTRUCTION_TYPES.JOYPAD:
			keyboard_button.modulate.a = 0.3
			joypad_button.modulate.a = 1.0
			grid_container_keyboard.hide()
			grid_container_joypad.show()
	
	keyboard_button.release_focus()
	joypad_button.release_focus()


func pause_demo() -> void:
	#_demo_mouse_mode = Input.mouse_mode
	get_tree().paused = true
	demo_page_root.show()
	var tween := create_tween()
	tween.tween_property(demo_page_root, "modulate", Color.WHITE, 0.3)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func resume_demo() -> void:
	get_tree().paused = false
	var tween := create_tween()
	tween.tween_property(demo_page_root, "modulate", Color.TRANSPARENT, 0.3)
	tween.tween_callback(demo_page_root.hide)
	Input.mouse_mode = _demo_mouse_mode as Input.MouseMode





func _on_play_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$CanvasLayer.hide()
	#get_tree().change_scene_to_file("res://Scenes/Levels/prototype.tscn")
