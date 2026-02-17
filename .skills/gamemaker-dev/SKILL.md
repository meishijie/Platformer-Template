---
name: gamemaker-dev
description: GameMaker Studio 2 平台游戏开发技能包。用于创建游戏对象、精灵、碰撞系统、敌人AI、玩家控制、道具系统等。当用户提到GameMaker、GML、游戏开发、平台游戏相关任务时使用。
---

# GameMaker Studio 2 平台游戏开发技能

## 项目概述

这是一个 GameMaker Studio 2 平台游戏模板项目，包含完整的玩家控制、敌人AI、碰撞系统、道具收集等功能。

## 项目结构

```
objects/
├── obj_character_parent/    # 角色基类（玩家和敌人的父类）
├── obj_player/              # 玩家对象
├── obj_enemy_parent/        # 敌人基类
├── obj_enemy1/              # 基础敌人
├── obj_enemy2/              # 进阶敌人
├── obj_coin/                # 金币道具
├── obj_invincible_star/     # 无敌星星道具
├── obj_block_parent/        # 方块基类
├── obj_block_coins/         # 金币方块
├── obj_block_star/          # 无敌星方块
└── obj_effect_parent/       # 特效父类

sprites/
├── spr_player_*             # 玩家精灵
├── spr_enemy*               # 敌人精灵
├── spr_coin*                # 金币精灵
└── spr_invincible_*         # 无敌星精灵

scripts/
└── scr_collisions/          # 碰撞检测函数
```

## 编码规范

### GML 代码风格

1. **变量命名**：使用 snake_case（如 `move_speed`, `jump_speed`）
2. **局部变量**：使用下划线前缀（如 `var _dist = 10;`）
3. **注释**：使用双斜杠 `//` 进行单行注释
4. **缩进**：使用制表符（Tab）

### 对象继承结构

```
obj_character_parent
├── obj_player
└── obj_enemy_parent
    ├── obj_enemy1
    └── obj_enemy2

obj_effect_parent
├── obj_coin_collect_effect
└── obj_invincible_collect_effect

obj_block_parent
├── obj_block_coins
└── obj_block_star
```

## 核心系统

### 1. 碰撞检测系统

使用 `check_collision(_move_x, _move_y)` 函数进行碰撞检测：

```gml
// 逐像素移动检测
var _move_count = abs(vel_x);
var _move_once = sign(vel_x);

repeat (_move_count) {
    var _collision_found = check_collision(_move_once, 0);
    if (!_collision_found) {
        x += _move_once;
    } else {
        vel_x = 0;
        break;
    }
}
```

### 2. 角色属性系统

角色基类 `obj_character_parent` 定义了核心属性：

```gml
// 移动参数
move_speed = 8;
jump_speed = 23;
grav_speed = 1;
friction_power = 0.7;

// 速度变量
vel_x = 0;
vel_y = 0;

// 状态
grounded = false;
hp = max_hp;
no_hurt_frames = 0;
```

### 3. 无敌帧系统

```gml
if (no_hurt_frames > 0) {
    no_hurt_frames -= 1;
    if (no_hurt_frames % 12 > 6) {
        image_alpha = 0;
    } else {
        image_alpha = 1;
    }
}
```

### 4. 道具系统

道具拾取模式：

```gml
// 玩家碰撞事件
instance_create_layer(other.x, other.y, "Instances", obj_collect_effect);
audio_play_sound(snd_collect, 0, 0);
instance_destroy(other);
```

### 5. 敌人AI系统

```gml
// 墙壁检测转向
var _wall_found = check_collision(vel_x * 4, 0);
if (_wall_found) {
    vel_x = -vel_x;
}

// 悬崖检测转向
var _ground_ahead = check_collision(vel_x * 32, 64);
if (!_ground_ahead && grounded) {
    vel_x = -vel_x;
}
```

## 创建新功能指南

### 创建新的可拾取道具

1. 创建精灵（建议64x64像素）
2. 创建对象，设置精灵
3. 添加 Create 事件：
   ```gml
   image_index = irandom_range(0, image_number - 1);
   ```
4. 在 `obj_player` 中添加碰撞事件
5. 更新 `obj_player.yy` 文件
6. 更新项目 `.yyp` 文件

### 创建新的敌人类型

1. 创建精灵和对象
2. 设置父对象为 `obj_enemy_parent`
3. 在 Create 事件中：
   ```gml
   event_inherited();
   defeated_object = obj_enemy_defeated;
   move_speed = 3;
   max_hp = 2;
   hp = max_hp;
   damage = 1;
   vel_x = choose(-move_speed, move_speed);
   ```

### 创建新的方块类型

1. 创建对象，设置父对象为 `obj_block_parent`
2. 添加 User Event 0（事件号10）处理撞击逻辑
3. 调用 `event_inherited()` 执行父类动画

## 精灵资源规范

### 文件格式

- 使用 PNG 格式
- 精灵帧文件命名：使用 GUID 格式
- 目录结构：
  ```
  sprites/spr_name/
  ├── spr_name.yy
  ├── <frame_guid>.png
  └── layers/
      └── <frame_guid>/
          └── <layer_guid>.png
  ```

### 动画帧率

- 玩家动画：15 FPS
- 敌人动画：12 FPS
- 特效动画：60 FPS
- 道具动画：15 FPS

## 音效资源

现有音效：
- `snd_coin_collect_01` - 金币收集
- `snd_enemy_hit` - 敌人被击中
- `snd_box_hit` - 方块撞击
- `snd_box_get` - 方块奖励获取
- `snd_jump` - 玩家跳跃

## 常见问题解决

### 项目加载失败

1. 检查 `.yyp` 文件中的资源引用
2. 确保精灵帧文件存在于正确路径
3. 验证 GUID 格式正确

### 碰撞检测问题

1. 确保对象有碰撞掩码
2. 检查 `obj_collision` 和瓦片碰撞层
3. 验证 `check_collision()` 函数调用

### 动画不播放

1. 检查精灵的 `image_speed` 设置
2. 确保精灵有多帧
3. 验证 `image_index` 未被锁定

## 参考资源

- [GameMaker 官方文档](https://manual.yoyogames.com/)
- [GML 语言参考](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/GML_Reference.htm)
