if (!invincible_star)
{
    invincible_star = true;
    invincible_star_timer = 600;
    no_hurt_frames = 600;
    rainbow_hue = 0;
}

instance_create_layer(other.x, other.y, "Instances", obj_invincible_collect_effect);

audio_play_sound(snd_coin_collect_01, 0, 0);

instance_destroy(other);
