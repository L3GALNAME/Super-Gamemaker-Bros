/// @description Varaible setup
// You can write your code in this editor
thing = 0;

#region Camera
    //Camera
    global.camera = 0
    global.cameraVar = array_create(0)
    //size
    global.cameraVar[0] = 256
    global.cameraVar[1] = 224
    // camera/object pos
    global.cameraVar[2] = 0
    global.cameraVar[3] = 0
    //following?
    global.cameraVar[4] = false
    ////follow object
    global.cameraVar[5] = 0
    //size barrier toggle
    global.cameraVar[6] = true
    global.cameraVar[7] = true
    //pos barrier toggle
    global.cameraVar[8] = true
    global.cameraVar[9] = true
    //follow x and y
    global.cameraVar[10] = true
    global.cameraVar[11] = false
    //offset
    global.cameraVar[12] = [0, 0];
    ////offset real
    global.cameraVar[13] = 0;
    global.cameraVar[14] = 0;

    global.shake = array_create(0);
    // left/right shake switches
    global.shake[0] = true;
    global.shake[1] = true;
    //shake speed
    global.shake[2] = 100;
#endregion

#region keybinds
    //keybinds
    global.keybinds = array_create(0);
    global.keybinds[0] = ord("W");
    global.keybinds[1] = vk_up;
    global.keybinds[2] = ord("A");
    global.keybinds[3] = vk_left;
    global.keybinds[4] = ord("S");
    global.keybinds[5] = vk_down;
    global.keybinds[6] = ord("D");
    global.keybinds[7] = vk_right;
    global.keybinds[8] = ord("Z");
    global.keybinds[9] = vk_enter;
    global.keybinds[10] = ord("X");
    global.keybinds[11] = vk_shift;
    global.ctrl = [0, 0, 0, 0, 0, 0];
    
    #macro ctrlLen array_length(global.ctrl)
#endregion

//global.startPos = [1020, 920];
global.startPos = [48, 208];

global.layers = array_create(0);

#region palette setting
    global.time = array_create(0);
    //Real Time
    global.time[0] = [0, 0];
    //Time Offset
    if (get_timer() > 0) { global.time[0][1] = get_timer() }
    //In game time
    global.time[1] = [0, 0];
	// Stored pause time
	global.time[2] = [0, 0, 0, 0];
    
    global.palIdx = 0;
    global.colorMod = array_create(0);
    //Characters
    global.colorMod[0] = [
        ColorModFromSprite(pal_Mario, 0, true),
        ColorModFromSprite(pal_groundEnemy, 0, true),
        ColorModFromSprite(pal_greenEnemy, 0, true),
    ];
    //Tiles
    global.colorMod[1] = [
        ColorModFromSprite(pal_OWTiles,  0, true), 
        ColorModFromSprite(pal_sceneryTiles,  0, true), 
        ColorModFromSprite(pal_skyTiles,  0, true),
        ColorModFromSprite(pal_coin, 0, true),
        ColorModFromSprite(pal_flower, 0, true),
        ColorModFromSprite(pal_mushroom, 0, true),
    ];
#endregion

surface_resize(application_surface, 256, 224)

////ALL FONT CHARACTERS IN ORDER DO NOT TOUCH
#macro soup " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_"

enum pipeD { DOWN, UP, LEFT, RIGHT };

paused = false;
prePause = paused;
paused_surf = -1;
pauseAnim = false;

spr_custom = -1;
objectVars = [];
playerVars = "Small";
global.canMove = true;

frame = 0;

global.points = [
	100,
	200,
	400,
	500,
	800,
	1000,
	2000,
	4000,
	5000,
	8000,
	10000,
];
global.coins = 0;
score = 0;

levelComplete = true;
global.sound = sfx_coin;

roomTrans = rm_1_1;
room = rm_transition;

// Audio
#region audio setting
	switch (os_browser) {
	    case browser_not_a_browser:
	        switch (os_type) {
	            case os_windows:
	            case os_macosx:
	                audio_channel_num(200);
	            break;

	            default:
	                audio_channel_num(64);
	            break;
	        }
	    break;

	    default:
	        audio_channel_num(16);
	    break;
	}

	audio_group_load(audiogroup_sfx)

	function music_toggle() {
		switch global.palIdx {
			case 0:
				if !audio_is_paused(mus_ground) {
					audio_pause_sound(mus_ground);
				} else {
					audio_resume_sound(mus_ground);
				}
			break;
			case 1:
				if !audio_is_paused(mus_underground) {
					audio_pause_sound(mus_underground);
				} else {
					audio_resume_sound(mus_underground);
				}
			break;
			case 2:
				if !audio_is_paused(mus_castle) {
					audio_pause_sound(mus_castle);
				} else {
					audio_resume_sound(mus_castle);
				}
			break;
			case 3:
				if !audio_is_paused(mus_underwater) {
					audio_pause_sound(mus_underwater);
				} else {
					audio_resume_sound(mus_underwater);
				}
			break;
		}
	}
#endregion