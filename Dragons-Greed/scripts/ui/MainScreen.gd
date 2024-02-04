extends Control

# Variables
var wide_left_panel
var wide_right_panel
var window_size
var screen_split = 0.67
# Nodes
var texture_rect_left
var texture_rect_right
var dragon_node
var dragon_constants = [ 0.5, 0.40 ,3 ] # x, y position and scaling

func _ready():
	window_size = get_viewport_rect().size  # Get the current window size

	wide_left_panel = $WideLeft
	wide_right_panel = $WideRight

	#print(window_size.x)
	#print(window_size.y)
	self.size.x = window_size.x  # Set the Control node's minimum size to the window size
	self.size.y = window_size.y
	resize_panels()
	
	# Base Images
	texture_rect_left = $WideLeft/TextureRect
	texture_rect_left.size = wide_left_panel.size
	
	texture_rect_right = $WideRight/TextureRect
	texture_rect_right.size = wide_right_panel.size
	
	# Dragon
	scale_dragon()

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

func scale_dragon():
	dragon_node = $WideLeft/Dragon
	dragon_node.position = Vector2(wide_left_panel.size.x * dragon_constants[0],
	 wide_left_panel.size.y * dragon_constants[1])
	
	# Scale the Dragon node
	dragon_node.scale = Vector2(dragon_constants[2], dragon_constants[2])
