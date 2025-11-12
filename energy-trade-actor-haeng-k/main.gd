extends Panel

enum page{Trade,Catalogue,MyPage}

func change_window(pages:page,nextpage:page):
	var trade_page=get_node("Trade page")
	var catalogue_page=get_node("Catalogue page")
	var my_page=get_node("My Page page")
	var pagearray=[trade_page,catalogue_page,my_page]
	var magni=Vector2(0.7,0.7)
	var range=800
	for i in range(3):
		if i==pages:
			pagearray[(i+1)%3].position.x+=range
			pagearray[(i+2)%3].position.x-=range
		else:
			pagearray[i].scale=magni
			pagearray[i].visible=true
			pagearray[i].z_index=2

	var tween=create_tween()
	tween.parallel().tween_property(pagearray[pages],"scale",magni,0.2)
	tween.tween_callback(
		func ():
			%Blur.visible=true
			pagearray[pages].z_index=2
			if nextpage==(pages+2)%3:
				await get_tree().create_timer(0.4).timeout
				var tween2=create_tween()
				tween2.parallel().tween_property(pagearray[(pages+2)%3],"position",Vector2(16,16),0.7)
					
				
				tween2.parallel().tween_property(pagearray[(pages+2)%3],"position",pagearray[(pages+2)%3].position-Vector2(400,0),0.1)
				pagearray[(pages+2)%3].position=Vector2(1216,16)
				tween2.parallel().tween_property(pagearray[(pages+2)%3],"position",Vector2(16,16),0.7)
				tween2.parallel().tween_property(pagearray[pages],"position",Vector2(-1184,16),0.5)
				pagearray[pages].position=Vector2(1216,16)
				tween2.parallel().tween_property(pagearray[pages],"position",Vector2(816,16),0.3)
				tween2.parallel().tween_property(pagearray[(pages+1)%3],"position",Vector2(-784,16),0.8)
			elif nextpage==(pages+1)%3:
				await get_tree().create_timer(0.4).timeout
				var tween2=create_tween()
				tween2.parallel().tween_property(pagearray[(pages+2)%3],"position",pagearray[(pages+2)%3].position-Vector2(400,0),0.1)
				pagearray[(pages+2)%3].position=Vector2(1216,16)
				tween2.parallel().tween_property(pagearray[(pages+2)%3],"position",Vector2(816,16),0.3)
				tween2.parallel().tween_property(pagearray[pages],"position",Vector2(-784,16),0.4)
				tween2.parallel().tween_property(pagearray[(pages+1)%3],"position",Vector2(16,16),0.4)
	)
