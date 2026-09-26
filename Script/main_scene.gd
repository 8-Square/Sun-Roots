class_name Main extends Node2D

@onready var sunlight_label: Label = $CanvasLayer/HBoxContainer/SunlightDisplay/SunlightLabel
@onready var water_label: Label = $CanvasLayer/HBoxContainer/WaterDisplay/WaterLabel
@onready var shop: Panel = $CanvasLayer/Shop
@onready var shop_panel: Control = $CanvasLayer/SecretOoglyBooglyShopHider

var save_pref: SaveManager


var sunlight: float = 0.0
var spc: float = 1 # sun per click

var water: float = 0.0
var wpc: float = 0.0 # water per click


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save_pref = SaveManager.load_or_create()
	# loads the save pref ones
	sunlight = save_pref.sunlight
	spc = save_pref.spc
	water = save_pref.water
	wpc = save_pref.wpc
	
	shop.visible = false
	shop_panel.visible = false


func save_values(): 
	save_pref.sunlight = sunlight
	save_pref.spc = spc
	save_pref.water = water
	save_pref.wpc = wpc
	save_pref.save()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_sunlight_value(sunlight)
	update_water_value(water)


# RAHH I GOT NO IDEA HOW TO MAKE THEM UPDATE THEIR OWN LABELS WITHOUT TWO FUNCTIons RAHH
func update_sunlight_value(value):
	sunlight_label.text = str(value)
func update_water_value(value):
	water_label.text = str(value)

func _on_character_pressed() -> void:
	sunlight += spc


func _on_upgrades_pressed() -> void:
	save_values()
	await get_tree().create_timer(0.3).timeout
	shop_panel.visible = true
	shop.visible = true

func _on_exit_pressed() -> void:
	save_values()
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scene/IntroScene.tscn")


func _on_secret_oogly_boogly_shop_hider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		shop.visible = false
		shop_panel.visible = false
