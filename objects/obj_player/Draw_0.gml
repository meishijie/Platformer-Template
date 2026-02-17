if (invincible_star)
{
    var _color = make_colour_hsv(rainbow_hue, 255, 255);
    
    image_blend = _color;
    gpu_set_blendmode(bm_add);
    draw_self();
    gpu_set_blendmode(bm_normal);
    image_blend = c_white;
}
else
{
    draw_self();
}
