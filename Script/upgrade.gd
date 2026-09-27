class_name Upgrade extends Resource

@export var id: String
@export var display_name: String
@export var description: String
@export var currency: String
@export var currency_icon: Texture2D
@export var base_cost: float
@export var cost_multiplier: float
@export var level: int = 0
@export var effect: float
@export var icon: Texture2D


func get_cost() -> float:
	return base_cost * pow(cost_multiplier, level)
