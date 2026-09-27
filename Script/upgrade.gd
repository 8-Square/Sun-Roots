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

#func _init(
#_id:String,
 #_display_name:String,
 #_description:String,
 #_currency:String,
#_base_cost: float,
#_cost_multiplier: float,
#_level: int,
#_effect_per_level: float,
#_icon: Texture2D
#) -> void:
	#id = _id
	#display_name = _display_name
	#description = _description
	#currency = _currency
	#base_cost = _base_cost
	#cost_multiplier = _cost_multiplier
	#level = _level
	#effect_per_level = _effect_per_level
	#icon = _icon
