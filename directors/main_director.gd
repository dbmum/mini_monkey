# main_director.gd

extends Node

var current_level
var level_scene
var level_scene_path_head
var level_scene_path_tail

# Called when the node enters the scene tree for the first time.
func _ready():
    current_level = 1
    level_scene_path_head = "res://play/level_maps/level_" 
    level_scene_path_tail = ".tscn"
    level_scene = load_new_level_scene()
    
    if level_scene:
        # Start the coroutine
        _connect()

func _connect():    
    # Connect the signal after the delay
    print("Connecting signal in _connect()")
    level_scene.connect("level_completed", self._on_level_completed)

func _on_level_completed():
    print("Level completed signal received")
    level_scene.queue_free()

    current_level += 1

    level_scene = load_new_level_scene()
    if level_scene:
        # Connect signal for the new level using a lambda function
        _connect()
    else:
        print("Failed to load new level scene")


func load_new_level_scene():
    var path = level_scene_path_head + str(current_level) + level_scene_path_tail
    
    # Check if the scene file exists
    if not ResourceLoader.exists(path):
        print("Error: Scene file not found - ", path)
        return
    
    var scene = load(path)
    
    # Check if the scene is a valid PackedScene
    if scene is PackedScene:
        var new_level_scene = scene.instantiate()
        get_tree().get_root().add_child.call_deferred(new_level_scene)
        return new_level_scene
    else:
        print("Error: Failed to load scene -", path)
        return null
    

func _on_audio_stream_player_2d_finished():
    $AudioStreamPlayer2D.play()
