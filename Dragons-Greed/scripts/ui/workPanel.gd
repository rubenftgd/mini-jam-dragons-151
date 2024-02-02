extends Panel

#########################################
# Core Values for the player
var work_money
var upgrade_a_bonus
var upgrade_b_bonus
var can_increase_money
#########################################
# Variables
var work_button
var upgrade_a_button
var upgrade_b_button
# Scaling factor
var scale_factor = 5  # Adjust this factor as needed
# Button colors
var color_work_button = Color(1, 0, 0)  # Red
var color_upgrade_a_button = Color(0, 1, 0)  # Green
var color_upgrade_b_button = Color(0, 0, 1)  # Blue

func _ready():
	#########################################
	# Core Values for the player
	work_money = 0
	upgrade_a_bonus = 1
	upgrade_b_bonus = [4, 0]  # 4 seconds and 0 upgrades
	can_increase_money = true  # To control when money can be increased
	#########################################
	
	work_button = $Work
	upgrade_a_button = $UpgradeA
	upgrade_b_button = $UpgradeB
	work_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	upgrade_a_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	upgrade_b_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	
func _process(_delta):
	position_buttons()

func position_buttons():
	# Apply scaling and set color for the work button
	work_button.scale = Vector2(scale_factor, scale_factor)
	work_button.modulate = color_work_button

	# Center the work button within the panel
	work_button.position = Vector2((size.x - work_button.size.x * scale_factor) / 2, (size.y - work_button.size.y * scale_factor) / 2)

	# Calculate offset for the triangle formation, adjusted for scaled size
	var offset = 20 * scale_factor  # Adjust based on desired spacing and scale

	# Apply scaling and set color for the a_upgrade button
	upgrade_a_button.scale = Vector2(scale_factor, scale_factor)
	upgrade_a_button.modulate = color_upgrade_a_button
	# Position relative to the work button
	upgrade_a_button.position = work_button.position + Vector2(-offset, offset)

	# Apply scaling and set color for the b_upgrade button
	upgrade_b_button.scale = Vector2(scale_factor, scale_factor)
	upgrade_b_button.modulate = color_upgrade_b_button
	# Position relative to the work button
	upgrade_b_button.position = work_button.position + Vector2(offset, offset)

func _on_work_pressed():
	if can_increase_money:
		can_increase_money = false  # Prevent further increases until the timer completes
		work_money += upgrade_a_bonus  # Increase work_money by the bonus amount
		print("Clicked on the Work Money Button")
		print("Work money: ", work_money); print("")

	$DelayTimer.start(upgrade_b_bonus[0] - upgrade_b_bonus[1])  # Start the timer with the desired delay

func _on_delay_timer_timeout():
	can_increase_money = true
	print("4 seconds have passed. You can work again!"); print("")
