event_inherited();

audio_play_sound(snd_box_hit, 0, 0);

if (sprite_index == spr_block_coins_inactive)
{
	exit;
}

sprite_index = spr_block_coins_inactive;

audio_play_sound(snd_box_get, 0, 0);

instance_create_layer(x + sprite_width / 2, y - 32, layer, obj_invincible_star);
