extends "res://Scripts/Interface.gd"

var labelArray : Array
var enemies_killed_label
var AISpawner
var enemies_killed = 0
var active_agents_in_last_frame = 0

func _ready():
	add_enemies_killed_label_node()

func _physics_process(delta):
	super(delta)
	update_enemies_killed_label()

func add_enemies_killed_label_node() -> void:
	if enemies_killed_label == null:
		var map_name = get_tree().current_scene.get_node("/root/Map/Core/UI/HUD/Info/Map")
		enemies_killed_label = map_name.duplicate()
		enemies_killed_label.name = "enemies_killed_label"
		enemies_killed_label.text = ""
		enemies_killed_label.hide()
		enemies_killed_label.set("theme_override_colors/font_outline_color", Color.BLACK)
		enemies_killed_label.set("theme_override_constants/outline_size", 4)
		map_name.get_parent().add_child(enemies_killed_label)
		AISpawner = get_tree().current_scene.get_node("/root/Map/AI")

func update_enemies_killed_label() -> void:
	if enemies_killed_label != null and AISpawner.spawnPool is int:
		if AISpawner.activeAgents < active_agents_in_last_frame:
			enemies_killed += (active_agents_in_last_frame - AISpawner.activeAgents)
		
		active_agents_in_last_frame = AISpawner.activeAgents
		enemies_killed_label.text = "Enemies Killed: %s/%s" % [enemies_killed, AISpawner.spawnPool]
		enemies_killed_label.show()

