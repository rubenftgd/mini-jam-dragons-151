extends Node2D

var money:int = 0
var deltval:float = 0.00
var is_guild_clicked:bool = false 
var is_backsmith_clicked:bool = false 

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
		if is_backsmith_clicked == false:
			%Dragon.position.x = 550
			get_node("Signal2").position.x += 210
			get_node("Signal2").flip_h = false 
			
		else:
			%Dragon.position.x = 280
			get_node("Signal2").position.x -= 210
			get_node("Signal2").flip_h = true 
		
	


func _on_guild_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if is_guild_clicked == false:
			%Dragon.position.x = 128
			get_node("Signal2").position.x -= 210
			get_node("Signal2").flip_h = true 
		%Dragon.position.x = 280
		get_node("Signal2").position.x += 210
		get_node("Signal2").flip_h = false


