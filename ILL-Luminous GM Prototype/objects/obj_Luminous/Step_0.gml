/// @description Code for every frame update

//===========================================================================
//===============================Controls Code===============================
//===========================================================================


// Pressing and holding D will move Luminous right
if keyboard_check(ord("D")) && !place_meeting(x + xSpeed, y, obj_HangarWalls_Par)
{
	hspeed = xSpeed // Assumes xSpeed is positive
	image_index = 0 // Changes direction Luminous is facing
}

// Pressing and holding A will move Luminous left
if keyboard_check(ord("A")) && !place_meeting(x - xSpeed, y, obj_HangarWalls_Par)
{
	hspeed = -xSpeed // Assumes xSpeed is positive
	image_index = 1 // Changes direction Luminous is facing
}

// Pressing space gives the initial jumping force
if keyboard_check_pressed(vk_space) && canJump == true
{
	vspeed = -23
	canJump = false // Takes away ability to jump
	
	//show_debug_message(vspeed)
}

// If holding space while jumping, gravity becomes weaker for higher jumps
if keyboard_check(vk_space) && canJump == false && vspeed < 0
{
	grv = grv_origin - 0.6
}

// Resets gravity when space is released
if keyboard_check_released(vk_space)
{
	grv = grv_origin
}

// Left mouse click uses weapon
if mouse_check_button_pressed(mb_left) && canAttack == true
{
	canAttack = false
	alarm[1] = room_speed // Starts attack cooldown
	show_debug_message("ATTACK")
}

// Right mouse click defends
if mouse_check_button_pressed(mb_right) && shieldBroken == false
{
	alarm[2] = room_speed * shieldMulti
	canBeHurt = false
	show_debug_message("DEFEND")
}

// Right mouse click release
if mouse_check_button_released(mb_right)
{
	alarm[2] = -1 // Stops shield broken timer
	canBeHurt = true
	show_debug_message("Released")
}

//===========================================================================
//===============================Movement Code===============================
//===========================================================================

// Gives Luminous gravity acceleration
if !place_meeting(x, y + 1.0, obj_HangarWalls_Par)
{
	if vspeed < termFallSpeed // Ensures the fall speed does not exceed terminal velocity
	{
		vspeed += grv
	}
	canJump = false // Takes away ability to jump
	
	//show_debug_message(vspeed)
}

// Slows Luminous horizontal speed overtime
if !keyboard_check(ord("D")) && hspeed > 0 
{
	hspeed -= dynFric
	
	//show_debug_message(hspeed)
}
else if !keyboard_check(ord("A")) && hspeed < 0
{
	hspeed += dynFric
	
	//show_debug_message(hspeed)
}

//===========================================================================
//=========================Collision Detection Code==========================
//===========================================================================

// Collision detection with walls for vertical speed
if place_meeting(x, y + vspeed, obj_HangarWalls_Par)
{
	// This loop ensures Luminous to land on ground in next frame
	while(place_meeting(x, y + vspeed, obj_HangarWalls_Par))
	{
		vspeed-- // Minuses vspeed until a collision will not happen
		
		if vspeed <= 0
		{
			vspeed = 0
			canJump = true // Allows Luminous to jump
			
			//show_debug_message(vspeed)
			
			break
		}
	}
}

// Collision detection with walls for horizontal speed
if place_meeting(x + hspeed, y, obj_HangarWalls_Par)
{
	// This loop ensures Luminous to stop moving horizontal in next frame
	while(place_meeting(x + hspeed, y, obj_HangarWalls_Par))
	{
		hspeed-- // Minuses hspeed until a collision will not happen
		
		if hspeed <= 0
		{
			hspeed = 0
			
			//show_debug_message(hspeed)
			
			break
		}
	}
}

// Collision detection with enemy
if place_meeting(x + hspeed, y + vspeed, obj_Orb_Par) && canBeHurt == true
{
	
	show_debug_message("Collision Detected with enemy")
	healthPts--
	canBeHurt = false // Starts invincibility frames
	image_alpha = 0.5 // Feedback for getting hurt
	alarm[0] = room_speed // Starts timer for resetting invincibility frames
	show_debug_message(healthPts)
}
