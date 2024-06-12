extends Control

var database : SQLite
# Called when the node enters the scene tree for the first time.
func _ready():
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	var table =  {
		"id" : {"data_type": "int" "primary_key" : true,"not_null":true, "auo_increment" : true
		}
	}


func _on_button_2_button_down():
	pass # Replace with function body.
