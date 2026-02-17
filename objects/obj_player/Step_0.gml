event_inherited();

// Set the position of the default audio listener to the player's position, for positional audio
// with audio emitters (such as in obj_end_gate)
audio_listener_set_position(0, x, y, 0);

// Handle invincibility star power-up
if (invincible_star)
{
    invincible_star_timer -= 1;
    rainbow_hue = (rainbow_hue + 5) mod 360;
    
    if (invincible_star_timer <= 0)
    {
        invincible_star = false;
        image_blend = c_white;
        image_alpha = 1;
    }
}