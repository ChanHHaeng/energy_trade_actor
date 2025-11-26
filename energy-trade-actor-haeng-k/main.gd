extends Control

enum page{Trade,Catalogue,MyPage}
signal tweenend

var nowpage=0

func change_window(pages:page,nextpage:page):
	var trade_page=get_node("Trade page")
	var catalogue_page=get_node("Catalogue page")
	var my_page=get_node("My Page page")
	var pagearray=[trade_page,catalogue_page,my_page]
	var magni=Vector2(0.7,0.7)
	var range=800
	var rangevector=Vector2(800,0)
	for i in range(3):
		if i==pages:
			pass
			#pagearray[(i+1)%3].position.x+=((i+1)%3-i)*range
			#pagearray[(i+2)%3].position.x+=((i+2)%3-i)*range
		else:
			pagearray[i].position.x+=(i-pages)*range
			pagearray[i].scale=magni
			pagearray[i].visible=true
			pagearray[i].z_index=2
			
	var tween=create_tween()
	tween.parallel().tween_property(pagearray[pages],"scale",magni,0.2)
	tween.tween_callback(
		func ():
			%Blur.visible=true
			pagearray[pages].z_index=2
			abs(nextpage-pages)
			if abs(nextpage-pages)==2:##끝과 끝 이동
				await get_tree().create_timer(0.4).timeout
				var tween2=create_tween()
				tween2.set_speed_scale(2)
				tween2.parallel().tween_property(pagearray[nextpage],"position",pagearray[nextpage].position-(nextpage-pages)*(rangevector),0.8)
				tween2.parallel().tween_property(pagearray[pages],"position",pagearray[pages].position-(nextpage-pages)*(rangevector),0.8)
				tween2.parallel().tween_property(pagearray[1],"position",pagearray[1].position-(nextpage-pages)*(rangevector),0.8)
				#tween2.tween_callback(
					#func ():
						#pagearray[(pages+2)%3].position=Vector2(1416,16)
				#)
				#tween2.tween_property(pagearray[(pages+2)%3],"position",Vector2(616,16),0.4)
				#tween2.parallel().tween_property(pagearray[pages],"position",Vector2(-984,16),0.4)
				#tween2.parallel().tween_property(pagearray[(pages+1)%3],"position",Vector2(-184,16),0.4)
				#tween2.tween_callback(
					#func ():
						#pagearray[pages].position=Vector2(1416,16)
				#)
				#tween2.tween_property(pagearray[(pages+2)%3],"position",Vector2(16,16),0.3)
				#tween2.parallel().tween_property(pagearray[pages],"position",Vector2(816,16),0.3)
				#tween2.parallel().tween_property(pagearray[(pages+1)%3],"position",Vector2(-784,16),0.3)
				tween2.tween_callback(
					func():
						emit_signal("tweenend")
						)
			elif abs(nextpage-pages)==1:
				await get_tree().create_timer(0.4).timeout
				var tween2=create_tween()
				tween2.set_speed_scale(2)
				tween2.parallel().tween_property(pagearray[pages],"position",pagearray[pages].position-(nextpage-pages)*(rangevector),0.4)
				tween2.parallel().tween_property(pagearray[(pages+1)%3],"position",pagearray[(pages+1)%3].position-(nextpage-pages)*(rangevector),0.4)
				tween2.parallel().tween_property(pagearray[(pages+2)%3],"position",pagearray[(pages+2)%3].position-(nextpage-pages)*(rangevector),0.4)
				#tween2.tween_callback(
					#func ():
						#pagearray[(pages+2)%3].position=Vector2(1416,16)
				#)
				#
				#tween2.tween_property(pagearray[pages],"position",Vector2(-784,16),0.3)
				#tween2.parallel().tween_property(pagearray[(pages+1)%3],"position",Vector2(16,16),0.3)
				#tween2.parallel().tween_property(pagearray[(pages+2)%3],"position",Vector2(816,16),0.3)
				tween2.tween_callback(
					func():
						emit_signal("tweenend")
						)
				
	)
	await tweenend
	await get_tree().create_timer(0.2).timeout
	for i in range(3):
		if i==nextpage:
			pagearray[(i+1)%3].position.x=16
			pagearray[(i+2)%3].position.x=16
			pagearray[i].z_index=0
		else:
			pagearray[i].scale=Vector2(1,1)
			pagearray[i].visible=false
			pagearray[i].z_index=0
	%Blur.visible=false
	var endtween=create_tween()
	endtween.tween_property(pagearray[nextpage],"scale",Vector2(1,1),0.2)
	print("go")
