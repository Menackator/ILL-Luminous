/// @description Code that runs upon creation of Luminous in the room

// Variable declaration for Luminous
grv_origin = 1.6//0.981 // Gravity constant original value
grv = grv_origin // Gravity constant
termFallSpeed = 26 // The terminal fall velocity of Luminous
xSpeed = 10 // Starting horizontal speed
ySpeed = 0 // Starting vertical speed
dynFric = (xSpeed * 2)/xSpeed // Dynamic friction coefficient, make sure it will converge to zero by using the xSpeed
healthPts = 10 // Luminous' starting health
shieldMulti = 4 // Length of room_speed's that Luminous can hold shield for

//inAir = false
canBeHurt = true // Luminous starts off being able to be hit
canJump = false // Used to determine if Luminous can currently jump
canAttack = true // Used to determine if Luminous can currently attack
shieldBroken = false // Shield starts out fine

image_speed = 0 // Stops automatic animation of Luminous

