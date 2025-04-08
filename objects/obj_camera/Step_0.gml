//// @description man wtf camera go brr
//quit game
if(keyboard_check(vk_escape) > 0) {
    esc += 1;
    if (esc > 59) {
        game_end();
    }
} else {
    esc = 0;
}

// Screen Shake
tick += global.shake[2];
shake[0] = global.shake[0]*(rShake * sin(tick));
shake[1] = global.shake[1]*(rShake * cos(tick));
rShake--;
if (rShake < 0) { rShake = 0; }

// Setting up variables
var cameraX = camera_get_view_x(global.camera);
var cameraY = camera_get_view_y(global.camera);
var CameraW = camera_get_view_width(global.camera);
var CameraH = camera_get_view_height(global.camera);
preScale = CameraH;

// Zooming
var targetW = cameraW / Scale;
var targetH = cameraH / Scale;

CameraW += (targetW - CameraW) / ScaleTime;
CameraH += (targetH - CameraH) / ScaleTime;
if ((CameraW > room_width) or (CameraH > room_height)) {
    if global.cameraVar[6] {
        CameraW = camera_get_view_width(global.camera);
    }
    if global.cameraVar[7] {
        CameraH = camera_get_view_height(global.camera);
    }
}

// Zoom Pos
var targetX = 0;
var targetY = 0;
if !(preScale = CameraH) {
    targetX = global.cameraVar[2] - (CameraW / 2);
    targetY = global.cameraVar[3] - (CameraH / 2);
    cameraX += targetX - cameraX;
    cameraY += targetY - cameraY;
}

//Positioning
cameraTarget = global.cameraVar[5]
if global.cameraVar[4] {
    if global.cameraVar[10] {
        global.cameraVar[2] = floor((cameraTarget.bbox_left + cameraTarget.bbox_right)/2) + global.cameraVar[13];
    }
    if global.cameraVar[11] {
        global.cameraVar[3] = floor((cameraTarget.bbox_top + cameraTarget.bbox_bottom)/2) + global.cameraVar[14];
    }
}
targetX = global.cameraVar[2] - (CameraW / 2);
targetY = global.cameraVar[3] - (CameraH / 2);

cameraX += (targetX - cameraX) / cameraSpeed;
if (cameraX < (camBordX + (global.cameraVar[13]*(global.cameraVar[13]<0))) and global.cameraVar[8]) {
    cameraX = camBordX + (global.cameraVar[13] * (global.cameraVar[13]<0));
} else if (cameraX + CameraW > room_width and global.cameraVar[8]) {
    cameraX = camBordX + (global.cameraVar[13] * (global.cameraVar[13]<0));
    if (CameraW <= room_width) {
        cameraX = room_width - CameraW;
    }
}

cameraY += (targetY - cameraY) / cameraSpeed
if(cameraY < 0 and global.cameraVar[9]) {
    cameraY = 0;
} else if (cameraY + CameraH > room_height and global.cameraVar[9]) {
    cameraY = 0;
    if (CameraH <= room_height) {
        cameraY = room_height - CameraH;
    }
}

//Apply
camera_set_view_pos(global.camera, floor(cameraX + shake[0]), floor(cameraY + shake[1]))
camera_set_view_size(global.camera, CameraW, CameraH)
x = cameraX; y = cameraY;
if (x > camBordX) { camBordX = x; }

mouseXPre = device_mouse_x_to_gui(0)
mouseYPre = device_mouse_y_to_gui(0)

//layer_x(global.layers[2]._id, x);
//layer_y(global.layers[2]._id, y);

////Foreground Parallax
//var lay = array_length(foreground)
//var floori = 0
//for (var i=0; i<lay; i++) {
//	floori = floor(i/2)
//	layer_x(foreground[i], x * (0.9-((1 - (1 / (floori+1) ))/2) ))
//	layer_y(foreground[i], (foregroundY) + ((y-(foregroundY)) * (0.9-((1 - (1 / (floori+1) ))/2) )))
//}

//cameraSpeed += (global.ctrl[2] = 0) - (global.ctrl[4] = 0)
//rShake = 2
//Scale = (-0.5 * cos(tick*0.1)) + 1.5

//if keyboard_check_pressed(vk_space) {
//	instance_create_layer(obj_handler.rmMouse[0], obj_handler.rmMouse[1], "Enemies", obj_enemyStand)
//	//particle_create("dust", spr_dustBunny, irandom_range(0, 2), 0, obj_handler.rmMouse[0], obj_handler.rmMouse[1], 1, 90*irandom_range(0, 3), random_range(-4, 4), 0, 0, -0.05, -0.02)
//}
