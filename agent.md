# GameMaker 平台游戏项目文档

## 项目 Agent Skills

本项目包含专用的 Agent Skills 技能包，位于 `.skills/gamemaker-dev/` 目录。

### 技能包结构

```
.skills/gamemaker-dev/
├── SKILL.md                    # 技能主文件
├── references/                 # 参考文档
│   ├── object-format.md        # 对象配置文件格式
│   └── sprite-format.md        # 精灵配置文件格式
└── templates/                  # 模板文件
    ├── create-item.md          # 创建新道具模板
    └── create-enemy.md         # 创建新敌人模板
```

### 使用方式

当 AI 助手处理 GameMaker 相关任务时，会自动加载此技能包，获得：
- 项目结构和编码规范
- 核心系统实现细节
- 创建新功能的指南和模板
- 配置文件格式参考

---

# 无敌星星道具功能实现

## 功能概述

在游戏中添加了一个可拾取的无敌星星道具，玩家拾取后会获得10秒无敌状态，期间角色会持续变换彩虹色，碰到敌人会直接消灭敌人。

## 创建的资源

### 精灵 (Sprites)

| 精灵名称 | 描述 |
|---------|------|
| `spr_invincible_star` | 无敌星星道具精灵，8帧彩虹色旋转动画 |
| `spr_invincible_collect_effect` | 收集特效精灵，20帧彩虹爆发动画 |

### 对象 (Objects)

| 对象名称 | 描述 |
|---------|------|
| `obj_invincible_star` | 可拾取的无敌星星道具 |
| `obj_invincible_collect_effect` | 收集时的彩虹爆发特效 |
| `obj_block_star` | 可掉落无敌星星的特殊方块 |

## 修改的文件

### 玩家对象 (obj_player)

**Create_0.gml** - 添加变量：
```gml
invincible_star = false;      // 是否处于无敌星星状态
invincible_star_timer = 0;    // 无敌时间计时器
rainbow_hue = 0;              // 彩虹色色相值
```

**Step_0.gml** - 处理无敌状态：
```gml
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
```

**Draw_0.gml** - 彩虹色渲染：
```gml
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
```

**Collision_obj_invincible_star.gml** - 拾取道具：
```gml
if (!invincible_star)
{
    invincible_star = true;
    invincible_star_timer = 600;  // 10秒 = 600帧 (60fps)
    no_hurt_frames = 600;
    rainbow_hue = 0;
}

instance_create_layer(other.x, other.y, "Instances", obj_invincible_collect_effect);
audio_play_sound(snd_coin_collect_01, 0, 0);
instance_destroy(other);
```

**Collision_obj_enemy_parent.gml** - 无敌时敌人死亡：
```gml
if (invincible_star)
{
    other.hp = 0;
    audio_play_sound(snd_enemy_hit, 0, 0);
    exit;
}
```

### 角色父类 (obj_character_parent)

**Step_2.gml** - 无敌星星状态下不闪烁：
```gml
var _has_star = false;
if (variable_instance_exists(id, "invincible_star"))
{
    _has_star = invincible_star;
}

if (!_has_star)
{
    // 原有的闪烁效果代码
}
```

## 使用方法

1. 在关卡编辑器中放置 `obj_block_star` 对象
2. 玩家从下方撞击方块，无敌星星会掉落
3. 玩家碰触无敌星星获得10秒无敌状态
4. 无敌期间角色呈现彩虹色，碰到敌人直接消灭

## 技术要点

- 无敌时间：600帧（10秒 @ 60fps）
- 彩虹色使用 HSV 颜色空间，每帧增加5度色相
- 使用加法混合模式 (bm_add) 增强发光效果
- 无敌星星状态与普通无敌帧状态分离处理
