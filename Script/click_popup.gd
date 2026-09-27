extends HBoxContainer

@onready var amount_label: Label = $AmountLabel
@onready var sun_icon: TextureRect = $SunIcon

func _ready() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y", position.y - 40, 0.5)
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.chain().tween_callback(queue_free)

func setup(amount: int, texture: Texture2D) -> void:
	sun_icon.texture = texture
	amount_label.text = "+" + str(amount)
	
