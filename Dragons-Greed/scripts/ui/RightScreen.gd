extends Panel

#########################################
# Button Variables
var work_button
var education_button
var speed_button
var gems_button
var space_available
var margin_percentage = 0.065 # Adjust at will
#########################################
# Classes Variables
var work_instance = Work.new()
var education_instance = Education.new()
var speed_instance = Speed.new()
var gems_instance = Gems.new()
#########################################
func _ready():
	work_button = $TextureRect/WorkButton
	education_button = $TextureRect/EducationButton
	speed_button = $TextureRect/SpeedButton
	gems_button = $TextureRect/GemsButton
#	work_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	education_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	speed_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	gems_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	var screen_percentage_available = 1 - get_parent().get_screen_split_value()
	var window_size = get_viewport_rect().size
	space_available = window_size.x * screen_percentage_available
	
func _process(_delta):
	position_buttons()

func position_buttons():
	# Base values for a standard screen size
	var base_button_width = 10  # The base width of a button before scaling
	var base_spacing = 5  # Base spacing between buttons
	var base_total_width = 4 * base_button_width + 3 * base_spacing  # Total width for 4 buttons and spacing

	# Calculate the proportional scale factor based on available space minus the margins
	var margin = space_available * margin_percentage
	var effective_space = space_available - 2 * margin  # Subtract margins from both sides
	var proportional_scale = effective_space / base_total_width

	# Adjust button width, scale factor, and spacing based on the proportional scale
	var button_width = base_button_width * proportional_scale
	var spacing = base_spacing * proportional_scale  # Adjust spacing based on available space

	# Calculate the total width needed for all 4 buttons and the spacing in between with new scale factor and spacing
	var total_width = 4 * button_width + 3 * spacing

	# Calculate the starting X position for the first button, now considering the left margin
	var start_x = margin + (effective_space - total_width) / 2  # Start after the left margin

	# Set a common Y position for all buttons, you might want to adjust this based on your UI needs
	var y_position = size.y * 0.20  # Example: 20% from the top of the parent container

	# Now, position and scale each button accordingly
	work_button.size = Vector2(button_width, button_width)
	work_button.position = Vector2(start_x, y_position)

	education_button.size = Vector2(button_width, button_width)
	education_button.position = Vector2(start_x + button_width + spacing, y_position)

	speed_button.size = Vector2(button_width, button_width)
	speed_button.position = Vector2(start_x + 2 * (button_width + spacing), y_position)

	gems_button.size = Vector2(button_width, button_width)
	gems_button.position = Vector2(start_x + 3 * (button_width + spacing), y_position)

func _on_delay_timer_timeout():
	work_instance.can_increase_money = true
	print("Time has passed. You can work again!"); print("")

func _on_work_button_pressed():
	if work_instance.can_increase_money:
		print("Clicked on the Work Money Button")
		work_instance.can_increase_money = false  # Prevent further increases until the timer completed
		$DelayTimer.start(speed_instance.total_time - speed_instance.bonus_reduce_time)  # Start the timer with the desired delay
		work_instance.work_money += education_instance.education_bonus  # Increase work_money by the bonus amount
		print("Work money: ", work_instance.work_money); print("")

func _on_education_button_mouse_entered():
	if work_instance.can_increase_money and (work_instance.work_money >= education_instance.education_bonus):
		print("Education Button")
		work_instance.work_money -= education_instance.education_bonus
		education_instance.applyBonus()
		print("New Value for Work money: ", education_instance.education_bonus); print("")

func _on_speed_button_mouse_entered():
	pass # Replace with function body.


func _on_gems_button_mouse_entered():
	pass # Replace with function body.
