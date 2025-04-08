/// @description Enter Pipe
canMove = false;
state = "Pipe";
action = "pipe";
layer = layer_get_id("Instances_Back");
audio_group_stop_all(audiogroup_default);
audio_play_sound(sfx_pipe, 75, false);
//obj_handler.objectVars = [];
//obj_handler.objectVars = [action, pipeDir, frame, animSpeed, luigi, x-obj_camera.x, y-8, dir];
//obj_handler.paused = true;
//global.time[2][0] = global.time[0][0];