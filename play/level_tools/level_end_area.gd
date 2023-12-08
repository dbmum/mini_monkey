extends Area2D

# Called when the node enters the scene tree for the first time.
signal level_completed()
var signal_emitted
func _ready():
    signal_emitted = false


func _on_area_entered(area):
    print("area signal emitted")
    #if not signal_emitted:
    emit_signal('level_completed')
    $CollisionShape2D.set_deferred("disabled", true)
    signal_emitted = true

