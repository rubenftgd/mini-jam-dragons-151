extends Control

# Variables
var wide_left_panel
var wide_right_panel
var window_size
var screen_plit = 0.67

func _ready():
	window_size = get_viewport_rect().size  # Get the current window size

	wide_left_panel = $WideLeft
	wide_right_panel = $WideRight

	#print(window_size.x)
	#print(window_size.y)
	self.size.x = window_size.x  # Set the Control node's minimum size to the window size
	self.size.y = window_size.y
	resize_panels()

func resize_panels():
	window_size = get_viewport_rect().size  # Get the current window size

	# Adjust the size and position of each panel based on the window size.
	wide_left_panel.size = Vector2(window_size.x * screen_plit, window_size.y)
	wide_right_panel.size = Vector2(window_size.x * (1 - screen_plit), window_size.y)

	# Set positions - assuming top left corner is (0, 0)
	wide_left_panel.position = Vector2(0, 0)
	wide_right_panel.position = Vector2(window_size.x * screen_plit, 0)
