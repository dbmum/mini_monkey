extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var max_jumps = 2
@export var pull_speed = 10
var num_jumps = 2
var hand_node
var swing_direction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
    hand_node = get_node("hand")
    
func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta

    # Handle Jump.
    if Input.is_action_just_pressed("jump") and num_jumps > 0:
        velocity.y = JUMP_VELOCITY
        num_jumps -= 1

    # Get the input direction and handle the movement/deceleration.
    var direction = Input.get_axis("left", "right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    
    if is_on_floor():
        num_jumps = max_jumps    
    

    if Input.is_action_just_pressed("swing1"):
        $AudioStreamPlayer2D.play()

    if Input.is_action_pressed("swing1"):
        # Basic rough swing effect
        var direction_to_hand = global_position.direction_to(hand_node.global_position)
        global_position = global_position + (direction_to_hand * pull_speed) 
        velocity.y -= gravity * delta
        
    move_and_slide()

        
