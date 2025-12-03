extends Popup

enum state{date,
time,
amount,
price,
from,
to}

@export var status:state


var min:int
var max:int

func possible_check():
	min=get_child(0).value
	max=get_child(1).value
	if !(min==0 and max==0):
		if min<=max: #둘 다 입력된 상황
			%"Master tree".fullcond[status][0]=min
			%"Master tree".fullcond[status][1]=max 
		elif max==0: #최소값만 입력된 상황
			%"Master tree".fullcond[status][0]=min
		else: #진짜 max가 min보다 작은 상황
			%"Master tree".fullcond[status][0]=min
			%"Master tree".fullcond[status][1]=max
	else:
		%"Master tree".fullcond[status][0]=0
		%"Master tree".fullcond[status][1]=10000
	#%"Master tree".fullcond[status][0]=min
	#%"Master tree".fullcond[status][1]=max
	%"Master tree".dataset()
