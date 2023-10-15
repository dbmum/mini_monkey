extends RigidBody2D

var freeze_position
var is_frozen
var mouse_pos
@export_node_path("CharacterBody2D") var main_node
@export var max_distance = 200
@export var speed = 50


# Called when the node enters the scene tree for the first time.
func _ready():
    main_node = get_parent()  # Assuming the main node is the parent of the subnode



func _physics_process(delta):
    var mouse_pos = get_global_mouse_position()

    var distance_to_main = mouse_pos.distance_to(main_node.global_position) 
    if distance_to_main < max_distance:
        global_position = mouse_pos
    else:
        var direction_to_mouse = main_node.global_position.direction_to(mouse_pos)
        global_position = main_node.global_position + (direction_to_mouse * max_distance)
    
        

    if Input.is_action_just_pressed('swing1'):
        freeze_position = global_position
        is_frozen = true
    if Input.is_action_pressed("swing1"):
        global_position = freeze_position
        global_rotation = 0
    if Input.is_action_just_released("swing1"):
        is_frozen = false
        
        
    
