extends ColorRect


func _on_minimum_size_changed() -> void:
	$ColorRect.size=Vector2(self.custom_minimum_size.x-6,self.custom_minimum_size.y-6)
	pass

func naming(buyer,seller,amount,price):
	$ColorRect/Label.text="purchase building number: "+str(int(buyer))+" \n seller building number: "+str(int(seller))+\
	"\n trade amount: "+str(amount)+"\n price: "+str(price)
	print($ColorRect/Label.size)
