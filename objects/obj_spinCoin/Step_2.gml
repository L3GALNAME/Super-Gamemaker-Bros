/// @description Movement
syReal += 0.4;
y += syReal;
if (y > startY) {
	instance_create_layer(x, startY-4, "Front", obj_scorePopup, { value : 200, syReal : -0.5 })
	instance_destroy();
}