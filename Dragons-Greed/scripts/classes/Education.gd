class_name Education

# Variables
var education_bonus: int
var education_bonus_first_term: int
var max_bonus_allowed: int

# Constructor
func _init(_education_bonus_first_term: int = 1, _max_bonus_allowed: int = 10):
	education_bonus_first_term = _education_bonus_first_term
	education_bonus = education_bonus_first_term
	max_bonus_allowed = _max_bonus_allowed

func applyBonus():
	if max_bonus_allowed >= 0:
		max_bonus_allowed-=1
		# Arithmetic Sequence
		# an = a1 + (n-1) * d
		# d is the upgrade amount per level - d is 11
		education_bonus = education_bonus_first_term + (max_bonus_allowed - 1) * 10
