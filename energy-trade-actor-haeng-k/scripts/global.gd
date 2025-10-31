extends Node


var postgrest="http://192.168.0.3"
var buy_data=[]
var transaction_buy=[]
var sell_data=[]
var transaction_sell=[]

var matching_result=[]


var date="2025-08-07"

var building_id=1

var now=13


var TimeSlots = [
	"06_00 ~ 07_00",
	"07_00 ~ 08_00",
	"08_00 ~ 09_00",
	"09_00 ~ 10_00",
	"10_00 ~ 11_00",
	"11_00 ~ 12_00",
	"12_00 ~ 13_00",
	"13_00 ~ 14_00",
	"14_00 ~ 15_00",
	"15_00 ~ 16_00",
	"16_00 ~ 17_00",
	"17_00 ~ 18_00",
	"18_00 ~ 19_00",
	"19_00 ~ 20_00",
	"20_00 ~ 21_00",
	"21_00 ~ 22_00",
	"22_00 ~ 23_00",
	"23_00 ~ 00_00",
	"00_00 ~ 01_00",
	"01_00 ~ 02_00",
	"02_00 ~ 03_00",
	"03_00 ~ 04_00",
	"04_00 ~ 05_00",
	"05_00 ~ 06_00"
]

func _enter_tree() -> void:
	print("global")
	for i in range(24):
		transaction_sell.append([])
		transaction_buy.append([])
		
func transaction_clear(serial):
	match serial:
		0:
			for i in range(24):
				transaction_buy[i].clear()
		1:
			for i in range(24):
				transaction_sell[i].clear()
				

var cardlen = 160


var focusing = null
