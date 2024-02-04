class_name Speed

# Variables
var total_time: float
var bonus_reduce_time: float
var max_bonus_allowed: int
var speed_price: Array[int]

# Constructor
func _init(_total_time: float = 4, _bonus_reduce_time: float = 0.35, _max_bonus_allowed: int = 10):
	total_time = _total_time
	bonus_reduce_time = _bonus_reduce_time
	max_bonus_allowed = _max_bonus_allowed
	speed_price = [20,30,50,85,150,225,330,610,900,1600]

func applyBonus():
	if max_bonus_allowed > 0:
		max_bonus_allowed-=1
		#print("Total time before bonus: ", total_time)
		total_time-=bonus_reduce_time
		#print("Total time after bonus: ", total_time)

func getSpeedPrice():
	if max_bonus_allowed > 0:
		# Correctly calculate the index of the next gem to purchase
		var index = speed_price.size() - max_bonus_allowed
		return speed_price[index]
	else:
		#print("No more speed upgrades available")
		return 0  # Or return an appropriate value indicating no more purchases are possible
