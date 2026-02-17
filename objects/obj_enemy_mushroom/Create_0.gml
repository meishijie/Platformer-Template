// ==================== DEBUG ====================
show_debug_message(">>> Mushroom Create! x=" + string(x) + " y=" + string(y));
// ==================== END DEBUG ====================

// 蘑菇敌人 - 继承父类
event_inherited();

// 确保 visible 为 true
visible = true;

show_debug_message(">>> Mushroom visible=" + string(visible));

// 设置敌人属性
// 移动速度比普通敌人慢
move_speed = 1.5;

// 伤害值
damage = 1;

// 生命值 - 蘑菇敌人只有1点生命
hp = 1;

// 死亡后替换为死亡动画对象
defeated_object = obj_enemy_mushroom_defeated;

// 初始移动方向 (向左)
vel_x = -move_speed;
