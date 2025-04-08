/// @description big -> small
canMove = false;
action = "transform";
state = "Small";
frame = 0;
animSpeed = 30/60;
obj_handler.objectVars = [];
obj_handler.objectVars = [action, state, frame, animSpeed, luigi, x-obj_camera.x, y-8, dir];
obj_handler.paused = true;
global.time[2][0] = global.time[0][0];
audio_play_sound(sfx_pipe, 75, false);