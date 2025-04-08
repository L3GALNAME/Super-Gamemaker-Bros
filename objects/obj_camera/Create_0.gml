esc = 0

cameraW = 256
cameraH = 224

//*
cameraSpeed = 2
cameraTarget = global.cameraVar[5]
camBordX = 0;

Scale = 1
ScaleTime = 1
preScale = 0
//*/

rShake = 0
shake = array_create(2)
tick = 0

mouseXPre = 0
mouseYPre = 0

global.camera = camera_create_view(x-(cameraW/2), 8, cameraW, cameraH, 0)

view_enabled = true
view_visible[0] = true
view_set_camera(0, global.camera)

//if surface_exists(global.surf2) {
//	view_surface_id[0] = global.surf2
//}

//foreground = []
//foreground2 = []
//foregroundY = 0

//background = spr_nfcBG
//background_idx = 0
palIdx = 0
