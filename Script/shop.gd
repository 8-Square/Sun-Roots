class_name Shop extends Panel

@onready var root_row: TextureRect = $VBoxContainer/RootRow
@onready var click_row: TextureRect = $VBoxContainer/ClickRow
@onready var leaf_row: TextureRect = $VBoxContainer/LeafRow
@onready var fertilizer_row: TextureRect = $VBoxContainer/FertilizerRow

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
