/// @description trigger slide
state = true;
scored = global.points[8 - round((obj_player.bbox_bottom - 48) / 18)]; // 18 comes from the height of the pole (y 192 - y 48)

var roomStr = room_get_name(obj_handler.roomTrans);
obj_handler.roomTrans = asset_get_index(
	string_copy(roomStr, 1, 5) + $"{real(string_copy(roomStr, 6, 5)) + 1}"
)