class_name Shop extends Control

@onready var click_row: TextureRect = $Shop/VBoxContainer/ClickRow
@onready var root_row: TextureRect = $Shop/VBoxContainer/RootRow
@onready var leaf_row: TextureRect = $Shop/VBoxContainer/LeafRow
@onready var fertilizer_row: TextureRect = $Shop/VBoxContainer/FertilizerRow


@onready var click_level_label: Label = $LevelOverview/VBoxContainer/ClickLevelLabel
@onready var root_level_label: Label = $LevelOverview/VBoxContainer/RootLevelLabel
@onready var leaf_level_label: Label = $LevelOverview/VBoxContainer/LeafLevelLabel
@onready var fertilizer_level_label: Label = $LevelOverview/VBoxContainer/FertilizerLevelLabel


var upgrades: Array[Upgrade] = []

func _ready() -> void:
	var click: Upgrade = preload("res://Script/upgrade_click.tres")
	var root: Upgrade = preload("res://Script/upgrade_root.tres")
	var leaf: Upgrade = preload("res://Script/upgrade_leaf.tres")
	var fertilizer: Upgrade = preload("res://Script/fertilizer.tres")
	upgrades = [click, root, leaf, fertilizer]
	
	var main = get_tree().get_first_node_in_group("main")
	click_row.setup(click, main)
	root_row.setup(root, main)
	leaf_row.setup(leaf, main)
	fertilizer_row.setup(fertilizer, main)

func refresh_rows() -> void:
	click_row.refresh_cost()
	root_row.refresh_cost()
	leaf_row.refresh_cost()
	fertilizer_row.refresh_cost()
	refresh_level_overview()

func refresh_level_overview() -> void:
	for upgrade in upgrades:
		var label_text = "Lv: " + str(upgrade.level)
		if upgrade.id == "click":
			click_level_label.text = "click " + label_text
		elif upgrade.id == "root":
			root_level_label.text = "root " + label_text
		elif upgrade.id == "leaf":
			leaf_level_label.text = "leaf " + label_text
		elif upgrade.id == "fertilizer":
			fertilizer_level_label.text = "fertilizer " + label_text
