// ==================== 敌人头顶名字 ====================
// 先绘制敌人精灵
draw_self();

// 计算文字位置 (头顶上方)
var _text_x = x;
var _text_y = y - sprite_height / 2 - 20;

// 绘制名字背景 (半透明黑色)
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(_text_x - 35, _text_y - 10, _text_x + 35, _text_y + 10, false);

// 绘制名字文本 (黄色)
draw_set_color(c_yellow);
draw_set_alpha(1);
draw_set_font(ft_hud);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_text_x, _text_y, "Mushroom");

// 重置绘制设置
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
// ==================== END ====================
