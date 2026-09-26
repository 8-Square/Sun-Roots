class_name SaveManager extends Resource

@export var save_version: int =1

@export var sunlight: float = 0
@export var spc: float = 1

@export var water: float = 0
@export var wpc: float = 1

func save() -> SaveManager:
	ResourceSaver.save(self, "user://save_manager.tres")
	return self

static func load_or_create() -> SaveManager:
	var res: SaveManager = load("user://save_manager.tres") as SaveManager
	if !res:
		res = SaveManager.new()
		res.save()
	if res.save_version > 2:
		res.save_version = 2
	return res
