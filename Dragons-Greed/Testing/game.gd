extends Node2D

var money:int = 0
var deltval:float = 0.00


func _ready():
	%Dragon.play_walk()
	

func _process(delta):
	deltval += delta
	if deltval > 1:
		money+=1
		get_node("ColorRect/RichTextLabel").text= str(money)
		deltval = 0 


func _on_blacksmith_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		%Dragon.position.x = 550
	
	


func _on_guild_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		%Dragon.position.x = 128
