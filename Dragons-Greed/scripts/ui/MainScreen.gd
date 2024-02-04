extends Control

# Variables
var wide_left_panel
var wide_right_panel
var window_size
var screen_split = 0.67
# Nodes
var texture_rect

func _ready():
	window_size = get_viewport_rect().size  # Get the current window size

	wide_left_panel = $WideLeft
	wide_right_panel = $WideRight

	#print(window_size.x)
	#print(window_size.y)
	self.size.x = window_size.x  # Set the Control node's minimum size to the window size
	self.size.y = window_size.y
	resize_panels()
	texture_rect = $WideLeft/TextureRect  # Adjust the path if your TextureRect is nested
	texture_rect.size = wide_left_panel.size  # Match the TextureRect size to the panel size

func resize_panels():
	window_size = get_viewport_rect().size  # Get the current window size

	# Adjust the size and position of each panel based on the window size.
	wide_left_panel.size = Vector2(window_size.x * screen_split, window_size.y)
	wide_right_panel.size = Vector2(window_size.x * (1 - screen_split), window_size.y)

	# Set positions - assuming top left corner is (0, 0)
	wide_left_panel.position = Vector2(0, 0)
	wide_right_panel.position = Vector2(window_size.x * screen_split, 0)

func get_screen_split_value():
	return screen_split
