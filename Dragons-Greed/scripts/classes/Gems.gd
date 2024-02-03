class_name Gems

# Variables
var gems_price: Array[int]
var gems_to_purchase: int

# Constructor
func _init(_gems_price: Array[int] = [2000, 5000, 10000], _gems_to_purchase: int = 3):
	gems_price = _gems_price
	gems_to_purchase = _gems_to_purchase

func purchaseGem():
	if gems_to_purchase > 0:
		gems_to_purchase -=1
		
func getGemPrice():
	if gems_to_purchase > 0:
		# Correctly calculate the index of the next gem to purchase
		var index = gems_price.size() - gems_to_purchase
		return gems_price[index]
	else:
		print("No more gems to purchase")
		return 0  # Or return an appropriate value indicating no more purchases are possible
