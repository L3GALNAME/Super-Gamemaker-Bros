/// @description Variable Init

// Visual
//type = 0; // 0 for Super Mushroom, 1 for 1UP
//state = 0; // 0 for moving, 1 for exiting block
offset = [0, 0];
//flower = false;

frame = 2;

// Movement
sxReal = 1;
syReal = 1;
fallCap = 3;

preSX = sxReal;

if (state == 1) { 
    offset[1] = 16;
    sxReal = 0;
}

inAir = 10;
onGround = true;