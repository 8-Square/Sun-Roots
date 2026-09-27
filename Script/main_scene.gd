class_name Main extends Node2D

@export var click_popup: PackedScene
@export var sun_texture: Texture2D
@onready var sunlight_label: Label = $CanvasLayer/HBoxContainer/SunlightDisplay/SunlightLabel
@onready var water_label: Label = $CanvasLayer/HBoxContainer/WaterDisplay/WaterLabel
@onready var shop: Control = $CanvasLayer/OverallShop

var save_pref: SaveManager



var sunlight: float = 0.0
var spc: float = 1 # sun per click
var sps: float = 1 # sun per second

var water: float = 0.0
var wps: float = 0.0 # water per click

var base_spc: float = 1.0
var base_sps: float = 0.0
var base_wps: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save_pref = SaveManager.load_or_create()
	# loads the save pref ones
	sunlight = save_pref.sunlight
	water = save_pref.water
	
	for upgrade in shop.upgrades:
		if save_pref.upgrade_levels.has(upgrade.id):
			upgrade.level = save_pref.upgrade_levels[upgrade.id]
	
	shop.refresh_rows()
	shop.visible = false
	recalculate_stats()
	update_values()


func save_values(): 
	save_pref.sunlight = sunlight
	save_pref.water = water
	for upgrade in shop.upgrades:
		save_pref.upgrade_levels[upgrade.id] = upgrade.level
	save_pref.save()


# RAHH I GOT NO IDEA HOW TO MAKE THEM UPDATE THEIR OWN LABELS WITHOUT TWO FUNCTIons RAHH
func update_values():
	sunlight_label.text = str(floori(sunlight))
	water_label.text = str(floori(water))

func _on_character_pressed() -> void:
	sunlight += spc
	update_values()
	spawn_click_popup()


func _on_upgrades_pressed() -> void:
	save_values()
	await get_tree().create_timer(0.3).timeout
	shop.visible = true
	

func _on_exit_pressed() -> void:
	save_values()
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scene/IntroScene.tscn")


func _on_secret_oogly_boogly_shop_hider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		shop.visible = false

func recalculate_stats() -> void:
	spc = base_spc
	sps = base_sps
	wps = base_wps
	
	var fertilizer_multiplier = 1.0
	for upgrade in shop.upgrades:
		var bonus = upgrade.level * upgrade.effect
		if upgrade.id == "click":
			spc += bonus
		elif upgrade.id == "root":
			wps += bonus
		elif upgrade.id == "leaf":
			sps += bonus
		elif upgrade.id == "fertilizer":
			fertilizer_multiplier += upgrade.level * upgrade.effect
	sps *= fertilizer_multiplier
	wps *= fertilizer_multiplier

func buy_upgrade(upgrade: Upgrade) -> bool:
	var cost = upgrade.get_cost()
	var current_amount = sunlight if upgrade.currency == "Sunlight" else water
	
	# if not enough, don't allow
	if current_amount < cost: 
		return false
	
	if upgrade.currency == "Sunlight":
		sunlight -= cost
	else:
		water -= cost
	
	upgrade.level += 1
	recalculate_stats()
	update_values()
	shop.refresh_level_overview()
	return true

# 15 second timer that updates stats if nothing has been clicked
func _on_timer_timeout() -> void:
	update_values()
	save_values()

func spawn_click_popup() -> void:
	var popup = click_popup.instantiate()
	$CanvasLayer.add_child(popup)
	
	var random_pos = Vector2(randf_range(-80, 80), randf_range(-80, 80))
	popup.global_position = $CanvasLayer/Character.global_position + random_pos
	popup.setup(floori(spc), sun_texture)


func _on_passive_timer_timeout() -> void:
	sunlight += sps
	water += wps
	update_values()
