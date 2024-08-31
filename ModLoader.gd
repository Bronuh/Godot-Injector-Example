extends Node

var main_path : String = "res://scenes/ui/main_menu.tscn"

func _ready() -> void:
	# Загрузка контента игры
	var success = ProjectSettings.load_resource_pack("res://CatBait.pck")
	
	if success:
		# Попытка поолучить путь к сцене из аргументов командной строки вроде --main=res://scenes/main/main.tscn
		var arguments = {}
		for argument in OS.get_cmdline_args():
			if argument.find("=") > -1:
				var key_value = argument.split("=")
				arguments[key_value[0].lstrip("--")] = key_value[1]
		
		# Если явно указан путь - используем его
		if arguments["main"]:
			main_path = arguments["main"]
		
		print("Mod Loader started")
		# Отложенный запуск искомой сцены, чтобы не конфликтовать с текущим вызовом _ready
		call_deferred("run")
		
func run():
	print("Attampt to run scene: " + main_path)
	get_tree().change_scene_to_file(main_path)
