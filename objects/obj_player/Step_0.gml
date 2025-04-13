var move_step = 64;
var move_x = 0;
var move_y = 0;


if (keyboard_check_pressed(ord("D"))) {
    move_x = move_step;
} else if (keyboard_check_pressed(ord("A"))) {
    move_x = -move_step;
} else if (keyboard_check_pressed(ord("W"))) {
    move_y = -move_step;
} else if (keyboard_check_pressed(ord("S"))) {
    move_y = move_step;
} else if (keyboard_check_pressed(ord("Space"))) {
    show_debug_message("ACTION!")
}



var new_x = x + move_x;
var new_y = y + move_y;

// this is basically all the logic for the main pusher
// i figure we can put this all in an if that checks to see if the player has 
// an item or pusher or whatever
if (instance_place(new_x, new_y, obj_wall) != noone) {
    // hit wall
    exit;
}

// 3. Box check
var box = instance_place(new_x, new_y, obj_box);
if (box != noone) {
   
    var box_new_x = box.x + move_x;
    var box_new_y = box.y + move_y;
    
    // this is basically the flag that makes sure that the player can move through things
    var can_push = true;
    
    // this is the wall check
    if (place_meeting(box_new_x, box_new_y, obj_wall)) {
        can_push = false;
    }
    
    // okay this is a little janky
    if (can_push) {
        // basically i'm just making it so we're looking at the next position,
		// not considering the OG box
        var original_box_x = box.x;
        var original_box_y = box.y;
        
        
        box.x = -1000;
        box.y = -1000;
        
        // if so, we say it can't go, like a wall
        if (place_meeting(box_new_x, box_new_y, obj_box)) {
            can_push = false;
        }
		else if (place_meeting(box_new_x, box_new_y, obj_exit)) {
            can_push = false;
        }
        
        // then move the box back. it's weird.
        box.x = original_box_x;
        box.y = original_box_y;
    }
    
    // if the flag is good, we can push box and player
    if (can_push) {
       
        box.x = box_new_x;
        box.y = box_new_y;
        
       
        x = new_x;
        y = new_y;
    }
} else {
    // after all the stuff is done, this is just here to move the player
    x = new_x;
    y = new_y;
}