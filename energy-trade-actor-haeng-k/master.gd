extends Control


@onready var userbox=load("res://userbox.tscn")


func transactioning() -> void:
	Global.matching_result.clear()
	for k in range(24): #시간별 탐색
		var i = 0 # i:판매 전용 단위
		var j = 0 # j:구매 전용 단위
		if (i<len(Global.transaction_sell[k]) and j<len(Global.transaction_buy[k])):
			pass
		else:
			continue
		var sell_amount=Global.transaction_sell[k][i][0]
		var buy_amount=Global.transaction_buy[k][j][0]
		while(i<len(Global.transaction_sell[k]) and j<len(Global.transaction_buy[k])): #0: 양 1: 가격
			if sell_amount==0:
				sell_amount=Global.transaction_sell[k][i][0]
			if buy_amount==0:
				buy_amount=Global.transaction_buy[k][j][0]
			
			if Global.transaction_sell[k][i][1]>Global.transaction_buy[k][j][1]:
				break #판매>구매인 상태. 이후 거래는 의미없음.
			#매수 확인 및 포인터 이동
			if sell_amount==buy_amount:#상호 거래량이 동일한 경우
				var middleGround=lerp(Global.transaction_sell[k][i][1],Global.transaction_buy[k][j][1],0.5)
				Global.matching_result.append([
					Global.date,
					k,
					middleGround,
					sell_amount,
					Global.transaction_buy[k][j][2],
					Global.transaction_sell[k][i][2],
					]) #날짜, 시간, 가격, 거래량, 구매자, 판매자
				j+=1
				i+=1
				sell_amount=0
				buy_amount=0
				
			elif sell_amount<buy_amount:#구매>판매일경우
				var middleGround=lerp(Global.transaction_sell[k][i][1],Global.transaction_buy[k][j][1],0.5)
				Global.matching_result.append([
					Global.date,
					k,
					middleGround,
					sell_amount,
					Global.transaction_buy[k][j][2],
					Global.transaction_sell[k][i][2],
					]) #날짜, 시간, 가격, 거래량, 구매자, 판매자
				buy_amount-=sell_amount #구매-판매
				sell_amount=0
				i+=1
				
				
			elif sell_amount>buy_amount:#판매>구매일경우
				var middleGround=lerp(Global.transaction_sell[k][i][1],Global.transaction_buy[k][j][1],0.5)
				Global.matching_result.append([
					Global.date,
					k,
					buy_amount,
					middleGround,
					Global.transaction_buy[k][j][2],
					Global.transaction_sell[k][i][2],
					]) #날짜, 시간, 가격, 거래량, 구매자, 판매자
				sell_amount-=buy_amount
				buy_amount=0
				j+=1
	
	%"Master tree".dataset()
