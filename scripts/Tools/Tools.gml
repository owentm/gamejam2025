function advance_tool(){
	var tool = instance_find(obj_tool,0)
	
	
	if (tool.state = "Pusher") {
		tool.state = "Smasher"
		tool.sprite_index = Smasher
	} else if (tool.state = "Smasher") {
		tool.state = "Pusher"
		tool.sprite_index = Pusher
	} 
		
}