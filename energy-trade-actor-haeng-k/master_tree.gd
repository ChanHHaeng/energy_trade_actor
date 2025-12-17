extends Tree


var root
var datecond=[]
var timecond=[]
var amountmin=0
var amountmax=10000
var pricemin=0
var pricemax=10000
var fromcond=[]
var tocond=[]
var fullcond=[datecond,timecond,[amountmin,amountmax],[pricemin,pricemax],fromcond,tocond]


func _ready() -> void:
	set_column_title(0,"date")
	set_column_custom_minimum_width(0,100)
	set_column_title(1,"time(1h)")
	set_column_custom_minimum_width(1,30)
	set_column_title(2,"amount(kW)")
	set_column_custom_minimum_width(2,60)
	set_column_title(3,"price(₩)")
	set_column_custom_minimum_width(3,60)
	set_column_title(4,"From")
	set_column_custom_minimum_width(4,100)
	set_column_title(5,"To")
	set_column_custom_minimum_width(5,100)
	y_sort_enabled=true


func dataset() ->void:
	clear()
	root=create_item()
	var condtable=[0,1,4,5]
	var valuetable=[2,3]
	for result in Global.matching_result: #데이터 필터링 이후 입력
		if Global.building_id!=0:
			if result[4]!=Global.building_id and result[5]!=Global.building_id:
				continue
		var condflag=true
		for i in condtable:
			if str(result[i]) in fullcond[i] or len(fullcond[i])==0:
				pass
			else:
				condflag=false
				break
		for i in valuetable:
			if result[i]<fullcond[i][0] or result[i]>fullcond[i][1]:
				condflag=false
				break
		if !condflag:
			continue
			
		var item=create_item(root)
		item.set_text(0,str(result[0]))
		item.set_text_alignment(0,HORIZONTAL_ALIGNMENT_CENTER)
		item.set_text(1,str(result[1])+" ~ "+str(int(result[1])+1))
		item.set_text_alignment(1,HORIZONTAL_ALIGNMENT_CENTER)
		item.set_text(2,str(int(result[2])))
		item.set_text_alignment(2,HORIZONTAL_ALIGNMENT_CENTER)
		item.set_text(3,str(int(result[3])))
		item.set_text_alignment(3,HORIZONTAL_ALIGNMENT_CENTER)
		item.set_text(4,"House number "+str(result[4]))
		item.set_text_alignment(4,HORIZONTAL_ALIGNMENT_CENTER)
		if result[4]==Global.building_id:
			item.set_custom_color(4,Color.BLUE) ## 파란 계열로 변경하면 될듯
			print("there?")
		item.set_text(5,"House number "+str(result[5]))
		item.set_text_alignment(5,HORIZONTAL_ALIGNMENT_CENTER)
		if result[5]==Global.building_id:
			print("here!")
			item.set_custom_color(5,Color.BLACK)
	for result in Global.matching_result: #데이터 중복 검사 및 필터링 등록
		if Global.building_id!=0:
			if result[4]!=Global.building_id and result[5]!=Global.building_id:
				continue
		
		var datemenu:PopupMenu= $Popups.get_child(0)
		var frommenu:PopupMenu=$Popups.get_child(4)
		var tomenu:PopupMenu=$Popups.get_child(5)
		var dupliflag=false
		for i in range(datemenu.item_count):
			if datemenu.get_item_text(i)==result[0]:
				dupliflag=true
				break
		if !dupliflag:
			datemenu.add_item(result[0])
			datemenu.set_item_as_checkable(-1,true)
		dupliflag=false
		for i in range(frommenu.item_count):
			if frommenu.get_item_text(i)==str(result[4]):
				dupliflag=true
				break
		if !dupliflag:
			frommenu.add_item(str(result[4]))
			frommenu.set_item_as_checkable(-1,true)
		
		dupliflag=false
		for i in range(tomenu.item_count):
			if tomenu.get_item_text(i)==str(result[5]):
				dupliflag=true
				break
		if !dupliflag:
			tomenu.add_item(str(result[5]))
			tomenu.set_item_as_checkable(-1,true)


func _on_column_title_clicked(column: int, _mouse_button_index: int) -> void:
	$Popups.get_child(column).popup()
	#$PopupMenu.popup_centered()
