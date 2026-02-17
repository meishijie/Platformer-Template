event_inherited();

// 设置敌人名字（显示在头顶）
enemy_name = "Jumping Turtle";

// 设置战败对象
defeated_object = obj_enemy3_defeated;

// 自定义属性 - 跳跃乌龟
move_speed = 1.5;        // 较慢的移动速度
max_hp = 3;              // 需要踩踏 3 次
hp = max_hp;
damage = 2;              // 对玩家造成 2 点伤害

// 跳跃参数
jump_speed = 18;         // 跳跃力度
jump_interval = 90;      // 1.5 秒跳跃一次 (60fps)

// 外壳防御状态
shell_mode = false;      // 是否处于缩壳状态
shell_timer = 0;         // 缩壳剩余时间

// 随机初始方向
vel_x = choose(-move_speed, move_speed);

// 设置跳跃闹钟
alarm[0] = jump_interval;
