# GameMaker 平台游戏项目文档

## GML 编码规范与最佳实践

### 一、命名规范 (Naming Conventions)

#### 资源命名前缀

| 资源类型 | 前缀 | 示例 |
|---------|------|------|
| Room | rm_ | rm_level_1 |
| Object | obj_ | obj_player |
| Sprite | spr_ | spr_player_idle |
| Script | scr_ | scr_collisions |
| Sequence | seq_ | seq_main_menu |
| Sound | snd_ | snd_coin_collect |
| TileSet | ts_ | ts_forest |
| Font | fnt_ | fnt_arial |

#### 变量命名

- **局部变量**：使用 snake_case（如 `local_x`, `move_speed`）
- **实例变量**：使用 `_` 前缀表示私有变量（如 `_hp`, `_internal_state`）
- **全局变量**：明确使用 `global.` 作用域
- **布尔变量**：以 `is_`, `has_`, `can_` 开头（如 `is_grounded`, `has_key`）

#### 常量命名

- 使用全大写 ALL_CAPS，带有意义的分组（如 `MAX_JUMP_COUNT`, `COLLISION_LAYER`）

---

### 二、代码风格 (Code Style)

#### 缩进与格式

- 使用 4 空格缩进
- 最大行长度：80 字符
- 逗号后加空格
- 运算符周围加空格，括号内不加空格

#### 控制结构

```gml
// 条件语句
if (condition) {
    // code
} else {
    // code
}

// 循环
for (var i = 0; i < count; i++) {
    // code
}

// Switch
switch (value) {
    case 1:
        // code
        break;
    default:
        // code
        break;
}
```

#### 注释规范

```gml
// 单行注释

/*
 * 多行注释
 * 保持星号对齐
 */

/// @description 函数描述
/// @param {real} arg1 参数说明
/// @returns {real} 返回值说明

// TODO: 待办事项
// FIXME: 需要修复的问题
// HACK: 临时解决方案
```

---

### 三、最佳实践 (Best Practices)

#### 1. 局部变量优先

```gml
// 推荐：清晰高效
var p_dir = point_direction(x, y, mouse_x, mouse_y);
var local_x = x + lengthdir_x(100, p_dir);
var local_y = y + lengthdir_y(100, p_dir);
draw_sprite(sprite_index, image_index, local_x, local_y);

// 不推荐：表达式重复调用
draw_sprite(sprite_index, image_index,
    x + lengthdir_x(100, point_direction(x, y, mouse_x, mouse_y)),
    y + lengthdir_y(100, point_direction(x, y, mouse_x, mouse_y)));
```

#### 2. 数组优化

```gml
// 预分配内存，避免频繁重分配
var arr = array_create(100, 0);

// 清理数组
arr = 0;
```

#### 3. 数据结构清理

- 使用 DS Maps、DS Lists 等数据结构后必须销毁
- 使用访问器使代码更简洁：`my_map[? "key" ]`

#### 4. 碰撞检测优化

| 函数类型 | 性能 | 用途 |
|---------|------|------|
| `place_` 函数 | 最快 | 位置检测 |
| `instance_` 函数 | 中等 | 实例检测 |
| `collision_` 函数 | 较慢 | 碰撞列表 |

- 优先使用 Tilemap 瓦片碰撞系统
- 避免像素级精确碰撞

#### 5. 渲染优化

- 避免频繁切换混合模式、着色器
- 使用控制器对象批量绘制：
```gml
gpu_set_blendmode(bm_add);
with (obj_BULLET) { draw_self(); }
gpu_set_blendmode(bm_normal);
```

#### 6. 使用代码区域

```gml
#region 移动逻辑
// 移动相关代码
#endregion

#region 碰撞检测
// 碰撞相关代码
#endregion
```

---

### 四、项目结构

```
objects/               # 游戏对象
├── obj_*_parent/     # 父类对象
├── obj_*/            # 具体对象
scripts/              # 脚本函数
sprites/              # 精灵资源
rooms/                # 关卡房间
sequences/            # 序列（UI、HUD）
```

---

## 项目文件格式与注册指南

### 一、资源文件格式 (.yy 文件)

所有 GMS2 资源都使用 JSON 格式的 `.yy` 配置文件。

#### 1. 对象 (.yy)

```json
{
  "$GMObject":"",
  "%Name":"obj_player",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
  ],
  "managed":true,
  "name":"obj_player",
  "parent":{
    "name":"Player",
    "path":"folders/Objects/Characters/Player.yy",
  },
  "parentObjectId":{
    "name":"obj_character_parent",
    "path":"objects/obj_character_parent/obj_character_parent.yy",
  },
  "spriteId":{
    "name":"spr_player_idle",
    "path":"sprites/spr_player_idle/spr_player_idle.yy",
  },
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
}
```

#### 2. 精灵 (.yy)

```json
{
  "$GMSprite":"v2",
  "%Name":"spr_player_idle",
  "frames":[
    {"$GMSpriteFrame":"v1","%Name":"uuid-string","name":"uuid-string","resourceType":"GMSpriteFrame","resourceVersion":"2.0",}
  ],
  "name":"spr_player_idle",
  "parent":{
    "name":"Player",
    "path":"folders/Sprites/Player.yy",
  },
  "resourceType":"GMSprite",
  "resourceVersion":"2.0",
}
```

#### 3. 脚本 (.yy)

```json
{
  "$GMScript":"v1",
  "%Name":"scr_collisions",
  "isCompatibility":false,
  "name":"scr_collisions",
  "parent":{
    "name":"Scripts",
    "path":"folders/Scripts.yy",
  },
  "resourceType":"GMScript",
  "resourceVersion":"2.0",
}
```

#### 4. 文件夹 (.yy)

```json
{
  "$GMFolder":"",
  "%Name":"Player",
  "children":[],
  "folderPath":"folders/Objects/Characters/Player.yy",
  "name":"Player",
  "resourceType":"GMFolder",
  "resourceVersion":"2.0",
}
```

---

### 二、UUID 生成与使用

#### 1. UUID 格式

GMS2 使用 UUID v4 格式：
- 格式：`xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`
- 示例：`5c82d1ea-f7f1-49ad-b457-0dbec6104618`

#### 2. 常见 UUID 类型

| 类型 | 字段名 | 说明 |
|------|--------|------|
| 精灵帧 | `%Name` in `GMSpriteFrame` | 每个帧独立的 UUID |
| 图层 | `%Name` in `GMImageLayer` | 每个图层独立的 UUID |
| 事件 | `%Name` in `GMEvent` | 对象事件的 UUID |

#### 3. UUID 生成

可以使用 Python 生成：
```python
import uuid
print(uuid.uuid4())  # 输出: 5c82d1ea-f7f1-49ad-b457-0dbec6104618
```

---

### 三、资源注册流程

#### 1. 注册到 .yyp 项目文件

在 `Platformer Template.yyp` 的 `resources` 数组中添加：

```json
{"id":{"name":"obj_new_object","path":"objects/obj_new_object/obj_new_object.yy",},}
```

#### 2. 对象事件文件命名规则

事件文件命名格式：`[EventType]_[EventNumber].gml`

| EventType | 说明 | 示例 |
|-----------|------|------|
| Create | 创建事件 | Create_0.gml |
| Destroy | 销毁事件 | Destroy_0.gml |
| Step | 步进事件 | Step_0.gml, Step_1.gml, Step_2.gml |
| Collision | 碰撞事件 | Collision_obj_enemy.gml |
| Keyboard | 键盘事件 | Keyboard_37.gml (←), Keyboard_39.gml (→) |
| KeyPress | 键按下 | KeyPress_32.gml (Space) |
| Other | 其他事件 | Other_0.gml (游戏开始), Other_7.gml (用户输入) |
| Draw | 绘制事件 | Draw_0.gml |
| Alarm | 闹钟事件 | Alarm_0.gml |

#### 3. 创建新资源的完整步骤

**创建新道具（如蘑菇）：**

1. 创建精灵目录和文件：
   ```
   sprites/spr_mushroom/
   ├── spr_mushroom.yy
   └── spr_mushroom.png (32x32)
   ```

2. 创建精灵 .yy 文件：
   ```json
   {
     "$GMSprite":"v2",
     "%Name":"spr_mushroom",
     "frames":[{"$GMSpriteFrame":"v1","%Name":"生成的uuid","name":"生成的uuid","resourceType":"GMSpriteFrame","resourceVersion":"2.0",}],
     "name":"spr_mushroom",
     "height":32,
     "width":32,
     "resourceType":"GMSprite",
     "resourceVersion":"2.0",
   }
   ```

3. 创建对象目录和文件：
   ```
   objects/obj_mushroom/
   ├── obj_mushroom.yy
   └── Create_0.gml
   ```

4. 创建对象 .yy 文件：
   ```json
   {
     "$GMObject":"",
     "%Name":"obj_mushroom",
     "eventList":[],
     "name":"obj_mushroom",
     "spriteId":{"name":"spr_mushroom","path":"sprites/spr_mushroom/spr_mushroom.yy",},
     "resourceType":"GMObject",
     "resourceVersion":"2.0",
   }
   ```

5. 在 .yyp 的 resources 中注册：
   ```json
   {"id":{"name":"obj_mushroom","path":"objects/obj_mushroom/obj_mushroom.yy",},}
   ```

---

### 四、事件类型参考

| EventType | 事件编号 | 说明 |
|-----------|---------|------|
| Create | 0 | 对象创建时执行 |
| Destroy | 1 | 对象销毁时执行 |
| Step | 2 | 每帧执行 (Step=0, Begin Step=1, End Step=2) |
| Collision | 4 | 与其他对象碰撞时 |
| Keyboard | 5 | 键盘按键持续按下 |
| Mouse | 6 | 鼠标事件 |
| Other | 7 | 其他事件 (0=游戏开始, 7=用户输入) |
| Draw | 8 | 绘制/渲染 |
| KeyPress | 9 | 键按下瞬间 |
| KeyRelease | 10 | 键释放瞬间 |
| Async | 12 | 异步事件 |

---

### 五、目录结构规范

```
项目根目录/
├── Platformer Template.yyp     # 项目主文件
├── folders/                    # 文件夹定义
│   ├── Objects.yy
│   ├── Objects/
│   │   └── Characters.yy
│   └── Sprites/
├── objects/                    # 游戏对象
│   ├── obj_player/
│   │   ├── obj_player.yy
│   │   ├── Create_0.gml
│   │   ├── Step_0.gml
│   │   └── Collision_obj_coin.gml
│   └── obj_*/
├── sprites/                    # 精灵资源
│   └── spr_player_idle/
│       ├── spr_player_idle.yy
│       └── spr_player_idle.png
├── scripts/                     # 脚本函数
│   └── scr_collisions/
│       ├── scr_collisions.yy
│       └── scr_collisions.gml
├── rooms/                       # 关卡房间
├── sequences/                   # 序列
├── sounds/                      # 音效
└── notes/                       # 文档
```

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
