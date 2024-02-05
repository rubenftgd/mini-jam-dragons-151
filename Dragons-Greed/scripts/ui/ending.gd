extends AcceptDialog

func _init():
	dialog_text = "Thank you for playing! Be sure to rate us on itch.io"

func _on_confirmed():
	get_tree().quit()  # This closes the game
