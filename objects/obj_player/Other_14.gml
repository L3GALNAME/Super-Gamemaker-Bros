/// @description Death
visible = false;
canMove = false;
action = "die";
state = "Die";
frame = 0;
syReal = 0;
obj_handler.objectVars = [];
obj_handler.objectVars = [action, state, frame, luigi, x-obj_camera.x, y-8, syReal, fallCap];
obj_handler.paused = true;
global.time[2][0] = global.time[0][0];
audio_group_stop_all(audiogroup_default);
audio_group_load(audiogroup_mus2);
audio_play_sound(mus_death, 100, false);