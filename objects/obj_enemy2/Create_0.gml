event_inherited();

// This is the object that replaces the enemy once it is defeated.
defeated_object = obj_enemy2_defeated;

// Set enemy name (displayed above head)
enemy_name = "Fast Slime";

// This sets the movement speed for this particular enemy (faster than enemy1).
move_speed = 4;

// Set initial HP for this enemy (more health than the default).
max_hp = 2;
hp = max_hp;

// This enemy deals more damage to the player.
damage = 2;

// This applies either move_speed or negative move_speed to the enemy's X velocity. 
// This way the enemy will either move left or right (at random).
// This action is present in the enemy parent object as well, but we're running it again in this child object,
// as its move_speed value has changed.
vel_x = choose(-move_speed, move_speed);
