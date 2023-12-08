extends TileMap


# Called when the node enters the scene tree for the first time.
signal level_completed


func _on_level_end_area_area_entered(area):
    print("tile signal recieved")
    emit_signal('level_completed')
