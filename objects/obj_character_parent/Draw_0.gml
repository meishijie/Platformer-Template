// Draw the sprite first
draw_self();

// Draw enemy name above head (only for enemies, not player)
if (object_index == obj_enemy_parent || object_index == obj_enemy1 || object_index == obj_enemy2 || object_index == obj_enemy3)
{
    // Set the name in Create event of each enemy
    if (variable_instance_exists(id, "enemy_name"))
    {
        var _font = draw_get_font();
        var _color = draw_get_color();
        var _halign = draw_get_halign();
        
        draw_set_font(ft_hud);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text_ext(x, y - sprite_height - 10, enemy_name, -1, -1);
        
        // Restore previous draw settings
        draw_set_font(_font);
        draw_set_color(_color);
        draw_set_halign(_halign);
    }
}
