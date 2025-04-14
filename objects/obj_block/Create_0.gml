/// @description Variable Init
offset = [0, 0];
thing = 0;
hit = false;
smash = false;

//enum Items { EMPTY, COIN, MUSHROOM, FIRE_FLOWER, ONEUP }
item = Items.EMPTY;
amount = 0;
state = true; // State == false means empty block
timer = 0;

origPos = [x, y];