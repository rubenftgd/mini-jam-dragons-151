class_name Work

# Variables
var work_money: int
var can_increase_money: bool

# Constructor
func _init(_work_money: int = 0, _can_increase_money: bool = true):
	work_money = _work_money
	can_increase_money = _can_increase_money

func get_paid(education_pay_money: int):
	work_money += education_pay_money
