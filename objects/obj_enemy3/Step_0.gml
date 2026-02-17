// 处理跳跃行为
if (!shell_mode && grounded)
{
    // 闹钟 0 控制定时跳跃
    if (alarm[0] <= 0)
    {
        vel_y = -jump_speed;
        alarm[0] = jump_interval + irandom_range(-30, 30); // 添加随机性
    }
}

// 处理缩壳状态
if (shell_mode)
{
    shell_timer -= 1;
    
    // 缩壳时不移动
    vel_x = 0;
    
    // 缩壳结束，恢复正常
    if (shell_timer <= 0)
    {
        shell_mode = false;
        image_alpha = 1;
        // 恢复移动
        vel_x = choose(-move_speed, move_speed);
    }
}
