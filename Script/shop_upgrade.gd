extends TextureRect

var upgrade: Upgrade
var main_ref: Node

func setup(_upgrade: Upgrade, _main_ref: Node) -> void:
	upgrade = _upgrade
	main_ref = _main_ref
	
	$Icon.texture = upgrade.icon
	$DisplayName.text = upgrade.display_name
	$Description.text = upgrade.description
	refresh_cost()
	$HBoxContainer/CurrencyIcon.texture = upgrade.currency_icon


func _on_buy_button_pressed() -> void:
	if main_ref.buy_upgrade(upgrade):
		refresh_cost()

func refresh_cost() -> void:
		$HBoxContainer/Cost.text = str(floori(upgrade.get_cost()))
