extends Panel

#########################################
# Button Variables
var work_button
var education_button
var speed_button
var gems_button
var space_available
var margin_percentage = 0.065 # Adjust at will
var progress_bar
var instructuions
var money_label_border
var money_label
#########################################
# Classes Variables
var work_instance = Work.new()
var education_instance = Education.new()
var speed_instance = Speed.new()
var gems_instance = Gems.new()
#########################################
# Music Variables
var money_sound
var education_sound
var speed_sound
var gems_sound
var winning_sound
#########################################
func _ready():
	work_button = $TextureRect/WorkButton
	education_button = $TextureRect/EducationButton
	speed_button = $TextureRect/SpeedButton
	gems_button = $TextureRect/GemsButton
	progress_bar = $TextureRect2/TextureProgressBar
	instructuions = $Instructions
	money_label_border = $TextureRectLabel
	money_label = $TextureRectLabel/Label
#	work_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	education_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	speed_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	gems_button.focus_mode = Control.FOCUS_NONE  # Disable focus for the button
	var screen_percentage_available = 1 - get_parent().get_screen_split_value()
	var window_size = get_viewport_rect().size
	space_available = window_size.x * screen_percentage_available
	
	money_sound = $MoneySound
	education_sound = $EducationSound
	speed_sound = $SpeedSound
	gems_sound = $GemsSound
	winning_sound = $WinningSound
	
func _process(_delta):
	position_buttons()
	if not $DelayTimer.is_stopped():
		var elapsed = $DelayTimer.wait_time - $DelayTimer.time_left
		var progress = min(elapsed / $DelayTimer.wait_time, 1.0)
		progress_bar.value = progress * 100

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
	
	##############################
	# Progress Bar
	#Posicao da progress bar (hardCoded), e o offset é para colocar a textura no sitio certo
	progress_bar.position = Vector2(50,200) 
	progress_bar.texture_progress_offset = Vector2(0,-6)
	
	##############################
	# Instructions
	#Posicao da progress bar (hardCoded), e o offset é para colocar a textura no sitio certo
	instructuions.position = Vector2(55,310)
	
	##############################
	# Money Label
	y_position = size.y * 0.055  # Example: 20% from the top of the parent container
	#money_label_border.size = Vector2(money_label_border.size.x * 1.3, money_label_border.size.y)
	var x_position_label = (space_available/2) - (money_label_border.size.x)/2
	money_label_border.position = Vector2(x_position_label, y_position)
	money_label.position = Vector2(30, 25)
	money_label.text = str(work_instance.work_money)

func _on_delay_timer_timeout():
	work_instance.can_increase_money = true
	print("Time has passed. You can work again!"); print("")
	work_instance.work_money += education_instance.education_bonus  # Increase work_money by the bonus amount
	play_sound_per_type(1)

func _on_work_button_mouse_entered():
	instructuions.modulate = Color(0.8, 1, 0)
	instructuions.text = "Work\nGain " + str(education_instance.education_bonus) + " Dragon Coins"

func _on_work_button_pressed():
	if work_instance.can_increase_money:
		print("Clicked on the Work Money Button")
		work_instance.can_increase_money = false  # Prevent further increases until the timer completed
		$DelayTimer.start(speed_instance.total_time - speed_instance.bonus_reduce_time)  # Start the timer with the desired delay
		#print("Work money: ", work_instance.work_money); print("")

func _on_education_button_mouse_entered():
	instructuions.modulate = Color(0,0,0)
	if education_instance.getEducationPrice() == 0:
		instructuions.text = "Education\n\nNo more upgrades available"
	else:
		instructuions.text = "Education\nGain more from work\n\nNext Level\n" + str(education_instance.getEducationBonus()) + " Dragon Coins\n\nCost\n" + str(education_instance.getEducationPrice()) + " Dragon Coins"

func _on_education_button_pressed():
	if work_instance.can_increase_money and (work_instance.work_money >= education_instance.getEducationPrice()) and (education_instance.getEducationPrice() != 0):
		print("Education Button")	
		work_instance.work_money -= education_instance.getEducationPrice()
		education_instance.applyBonus()
		play_sound_per_type(2)
		print("New Value for Work money: ", education_instance.education_bonus); print("")

func _on_speed_button_mouse_entered():
	instructuions.modulate = Color(0.8,0.8,0.8)
	if speed_instance.getSpeedPrice() == 0:
		instructuions.text = "Speed\n\nNo more upgrades available"
	else:
		instructuions.text = "Speed\nWork Faster\n\nCurrently Takes\n" + str(speed_instance.total_time) + " Seconds\n\nCost\n" + str(speed_instance.getSpeedPrice()) + " Dragon Coins"

func _on_speed_button_pressed():
	if work_instance.can_increase_money and (work_instance.work_money >= speed_instance.getSpeedPrice()) and (speed_instance.getSpeedPrice() != 0):
		print("Speed Button")
		work_instance.work_money -= speed_instance.getSpeedPrice()
		speed_instance.applyBonus()
		play_sound_per_type(3)

func _on_gems_button_mouse_entered():
	instructuions.modulate = Color(0.6,0.1,1)
	if gems_instance.getGemsPrice() == 0:
		instructuions.text = "Gems\n\nNo more upgrades available"
	else:
		instructuions.text = "Gems\nNever Ending Jewelry Treasure\n\nNext gem costs\n" + str(gems_instance.getGemsPrice()) + " Dragon Coins"

func _on_gems_button_pressed():
	if work_instance.can_increase_money and (work_instance.work_money >= gems_instance.getGemsPrice()) and (gems_instance.getGemsPrice() != 0):
		print("Gems Button")
		work_instance.work_money -= gems_instance.getGemsPrice()
		gems_instance.purchaseGem()
		play_sound_per_type(4)
	if gems_instance.getGemsPrice() == 0:
		show_thank_you_pop_up()

func play_sound_per_type(number : int):
	if number == 1:
		money_sound.play()
	elif number == 2:
		education_sound.play()
	elif number == 3:
		speed_sound.play()
	elif number == 4:
		gems_button.play()
	else:
		print("Error in the sound effects!")
		return 0

func show_thank_you_pop_up():
	var dialog = $AcceptDialog
	dialog.visible = true
	var game_scene = get_node("/root/GameScene")
	var parent_sound = game_scene.get_node("AudioStreamPlayer2D")
	if parent_sound:
		parent_sound.stop()
	winning_sound.play()
