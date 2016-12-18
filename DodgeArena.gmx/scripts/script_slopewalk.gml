/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////

// Script: Walking up/down slopes.
// Written by Seth Coster of Stoz Studios (www.stozstudios.com)
// Paste this into a script named something like "scr_Walk".
// Call this script in the key presses of your character which are for movement.
// When calling the script, use scr_Walk("left") to move left, and scr_Walk("right") to move right.
// Note: This script assumes the character has a variable called "movespeed" which determines how many pixels the character moves at a time. Use 10 as your base movespeed and tweak it from there.

// First we check which direction to walk.
if argument0 = "left" {
   dir = -1
   }
else if argument0 = "right" {
     dir = 1
     }

// Now that we have the direction, it's time to do the angle sweep. Since this will occur in a loop, it sweeps over a crapload of angles every step.

anglesweep = -90+40*dir; // This is the starting point of the sweep, in degrees.
anglerem = 100; // We're going to use a 100-degree sweep.
pathclear = 0; // "pathclear" is a toggle switch. If we find a path to walk, it gets set to "1" and we break the loop.

while (anglerem >= 0 && pathclear = 0){
      anglesweep += 5*dir; // We're doing 5-degree jumps in our sweep.
      anglerem -= 5; // Decrease "anglerem" by the degrees in each angle interval.

// Using the lengthdir function, we grab the x,y coordinates of the target location found for the current angle.
      groundspotx = x+lengthdir_x(movespeed,anglesweep)
      groundspoty = y+lengthdir_y(movespeed,anglesweep)

// Then, we check if the spot is free and if there's ground beneath it.
      if place_free(groundspotx,groundspoty) && !place_free(groundspotx,groundspoty+5)
             pathclear = 1 // If so, HOORAY! The path is clear for walking. If not, "pathclear" will stay at 0 and the loop will end after checking its 100 degree sweep.
      }

// The loop is now finished. Time to check if we have clear ground to walk on, and if we are already on the ground.
if (pathclear == 1 && !place_free(x,y+1)){
  // First, change the character's X and Y coordinates to the destination.
   x+=lengthdir_x(movespeed,anglesweep)
   y+=lengthdir_y(movespeed,anglesweep)
   move_contact_solid(270,15) // This will drop the character to contact with the ground if he ended up a few pixels above it.
   vspeed = 0 // Not required, but useful at times.
   hspeed = 0 // Not  required , but useful at times.
}
// If we failed the "path clear" test, we check to see if we're airborne. If so, we just move right/left in midair.
else if place_free(x+lengthdir_x(movespeed, 90-90*dir), y)
     x += dir*max(movespeed-abs(hspeed), 0)
// Last if we aren't airborne and have no clear path to walk, we'll just move to contact the closest solid obstacle.
else{
     move_contact_solid(90-90*dir, max(movespeed-abs(hspeed), 0))
     movingleft = 0
     movingright = 0
}
