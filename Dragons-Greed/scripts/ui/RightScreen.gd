extends Panel

#########################################
# Button Variables
var work_button
var education_button
var speed_button
var gems_button
# Scaling factor
var scale_factor = 4  # Adjust this factor as needed
var space_available
# Button colors
var color_work_button = Color(1, 0, 0)  # Red
var color_education_button = Color(0, 1, 0)  # Green
var color_speed_button = Color(0, 0, 1)  # Blue
var color_gem_button = Color(1, 1, 1)  # White
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
	work_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	education_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	speed_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	gems_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	space_available = 1 - get_parent().get_screen_split_value()
	
func _process(_delta):
	position_buttons()

func position_buttons():
	var total_width = 0
	var button_width = work_button.size.x * scale_factor  # Assuming all buttons have the same width
	var spacing = 10 * scale_factor  # Spacing between buttons

	# Calculate the total width needed for all 4 buttons and the spacing in between
	total_width = 4 * button_width + 3 * spacing

	# Calculate the starting X position for the first button to center the group of buttons
	var start_x = (size.x - total_width) / 2

	# Set a common Y position for all buttons, centering them vertically
	var y_position = (size.y - work_button.size.y * scale_factor) * 0.15

	# Now, position each button. Start with the 'work_button' and move right for each subsequent button.
	work_button.scale = Vector2(scale_factor, scale_factor)
	work_button.modulate = color_work_button
	work_button.position = Vector2(start_x, y_position)

	# Assuming you have two more buttons in addition to 'education_button' and 'speed_button', name them accordingly.
	education_button.scale = Vector2(scale_factor, scale_factor)
	education_button.modulate = color_education_button
	education_button.position = Vector2(start_x + button_width + spacing, y_position)

	speed_button.scale = Vector2(scale_factor, scale_factor)
	speed_button.modulate = color_speed_button
	speed_button.position = Vector2(start_x + 2 * (button_width + spacing), y_position)

	# Position the fourth button, assuming it's named 'gems_button'
	gems_button.scale = Vector2(scale_factor, scale_factor)
	# Set color for the fourth button if needed
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
