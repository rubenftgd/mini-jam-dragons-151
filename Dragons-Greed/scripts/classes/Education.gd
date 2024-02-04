class_name Education

# Variables
var education_bonus: int
var education_bonus_first_term: int
var max_bonus_allowed: int
var education_price: Array[int]

# Constructor
func _init(_education_bonus_first_term: int = 1, _max_bonus_allowed: int = 10):
	education_bonus_first_term = _education_bonus_first_term
	education_bonus = education_bonus_first_term
	max_bonus_allowed = _max_bonus_allowed
	defineEducationPrice()

func applyBonus():
	if max_bonus_allowed > 0:
		# Arithmetic Sequence
		# an = a1 + (n-1) * d
		# d is the upgrade amount per level - d is 11
		var index = education_price.size() - max_bonus_allowed + 1
		education_bonus = education_bonus_first_term + (index - 1) * 10
		print("New education Bonus: ", education_bonus)
		max_bonus_allowed-=1

func defineEducationPrice():
	# Sequence [10,16,26,43,70,114,185,302,491,799]
	var a1 = 10  # First term
	var an = 800  # A chosen value close to the middle of the 750 to 850 range
	var n = 10  # Number of terms
	# Calculate the common ratio
	var r = pow(an / a1, 1 / (n - 1))

	# Generate the geometric progression sequence and assign it to education_price
	for i in range(n):
		education_price.append(int(a1 * pow(r, i)))
	print(education_price)

func getEducationPrice():
	if max_bonus_allowed > 0:
		# Correctly calculate the index of the next gem to purchase
		var index = education_price.size() - max_bonus_allowed
		return education_price[index]
	else:
		print("No more education to pursue")
		return 0  # Or return an appropriate value indicating no more purchases are possible
