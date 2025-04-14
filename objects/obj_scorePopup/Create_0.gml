/// @description Setup
if (instance_exists(obj_camera)) {
	x -= obj_camera.x;
}
alarm[0] = 48

frame = 10;
if (typeof(value) != "string") {
	score += value;
	frame = array_get_index(global.points, value);
} else if (value == "1UP") {
	lives++;
}