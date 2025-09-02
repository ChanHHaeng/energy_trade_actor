extends ColorRect


var buyer
var seller
var amount
var time
var price

func _on_minimum_size_changed() -> void:
	$ColorRect.size=Vector2(self.custom_minimum_size.x-6,self.custom_minimum_size.y-6)
	pass

func naming(buyer,seller,amount,price,time):
	$ColorRect/Label.text="purchase building number: "+str(int(buyer))+" \n seller building number: "+str(int(seller))+\
	"\n trade amount: "+str(amount)+"\n price: "+str(price) + "\ntime: " + str(time)
	self.name=str(buyer)+str(seller)+str(amount)+str(price)+str(time)
	self.buyer=buyer
	self.seller=seller
	self.amount=amount
	self.time=time
	self.price=price
