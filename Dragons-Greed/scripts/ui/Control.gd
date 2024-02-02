extends Control

# Variables
var top_left_panel
var bottom_left_panel
var wide_right_panel
var window_size
# Colors, normalized to the 0-1 range
var color_top_left = Color(135 / 255.0, 206 / 255.0, 235 / 255.0)  # Light Blue
var color_bottom_left = Color(97 / 255.0, 28 / 255.0, 38 / 255.0)  # Brown
var color_wide_right = Color(211 / 255.0, 211 / 255.0, 211 / 255.0)  # Grey

func _ready():
	window_size = get_viewport_rect().size  # Get the current window size
	
	top_left_panel = $TopLeft
	bottom_left_panel = $BottomLeft
	wide_right_panel = $WideRight

	#print(window_size.x)
	#print(window_size.y)
	self.size.x = window_size.x  # Set the Control node's minimum size to the window size
	self.size.y = window_size.y
	set_panel_colors()
	resize_panels()

#func _process(_delta):
#	set_panel_colors()
#	resize_panels()

func resize_panels():
	window_size = get_viewport_rect().size  # Get the current window size

	# Adjust the size and position of each panel based on the window size.
	top_left_panel.size = Vector2(window_size.x / 2, window_size.y / 2)
	bottom_left_panel.size = Vector2(window_size.x / 2, window_size.y / 2)
	wide_right_panel.size = Vector2(window_size.x / 2, window_size.y)

	# Set positions - assuming top left corner is (0, 0)
	top_left_panel.position = Vector2(0, 0)
	bottom_left_panel.position = Vector2(0, window_size.y / 2)
	wide_right_panel.position = Vector2(window_size.x / 2, 0)

func set_panel_colors():
	top_left_panel.self_modulate = color_top_left
	bottom_left_panel.self_modulate = color_bottom_left
	wide_right_panel.self_modulate = color_wide_right
