class_name Speed

# Variables
var total_time: float
var bonus_reduce_time: float
var max_bonus_allowed: int

# Constructor
func _init(_total_time: float = 4, _bonus_reduce_time: float = 0.35, _max_bonus_allowed: int = 10):
	total_time = _total_time
	bonus_reduce_time = _bonus_reduce_time
	max_bonus_allowed = _max_bonus_allowed

func applyBonus():
	if max_bonus_allowed > 0:
		max_bonus_allowed-=1
		total_time-=bonus_reduce_time
