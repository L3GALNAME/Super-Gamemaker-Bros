/// @description Variable Init

// Visual
//type = 0; // 0 for Super Mushroom, 1 for 1UP
//state = 0; // 0 for moving, 1 for exiting block
offset = [0, 0];
//flower = false;

frame = 0;

// Movement
sxReal = 1;
syReal = 0;
fallCap = 6;

preSX = sxReal;

if (state == 1) { 
    offset[1] = 16;
    sxReal = 0;
}