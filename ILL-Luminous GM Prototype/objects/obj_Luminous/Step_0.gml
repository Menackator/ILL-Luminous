/// @description Code for every frame update

//===========================================================================
//===============================Controls Code===============================
//===========================================================================

// Pressing and holding D will move Luminous right
if keyboard_check(ord("D")) && !place_meeting(x + xSpeed, y, obj_HangarWalls_Par)
{
	x += xSpeed
	image_index = 0 // Changes direction Luminous is facing
}

// Pressing and holding A will move Luminous left
if keyboard_check(ord("A")) && !place_meeting(x - xSpeed, y, obj_HangarWalls_Par)
{
	x -= xSpeed
	image_index = 1 // Changes direction Luminous is facing
}

show_debug_message(image_index)

// Pressing space gives the initial jumping force
if keyboard_check_pressed(vk_space) && canJump == true
{
	vspeed = -20
	canJump = false // Takes away ability to jump
	show_debug_message(vspeed)
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
if mouse_check_button_pressed(mb_left)
{
	show_debug_message("ATTACK")
}

// Right mouse click defends
if mouse_check_button(mb_right)
{
	show_debug_message("DEFEND")
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
	show_debug_message(vspeed)
}



//===========================================================================
//=========================Collision Detection Code==========================
//===========================================================================

// Collision detection
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
			show_debug_message(vspeed)
			break
		}
	}
}
