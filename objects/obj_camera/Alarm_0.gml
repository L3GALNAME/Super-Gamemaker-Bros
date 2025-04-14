/// @description Deactivate out of bounds
instance_deactivate_object(obj_activatable);
if (room == rm_title) {
	instance_activate_region(x-72, 0, cameraW+(72*1.5), cameraH, true);
} else {
	instance_activate_region(x-72, 0, cameraW+(72*2), cameraH, true);
}
//instance_activate_region(x-72, 0, cameraW+(72*2), cameraH, true);