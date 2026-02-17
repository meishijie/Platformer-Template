---
name: gamemaker
description: GameMaker Studio 2 开发指南。用于创建、修改 GameMaker 项目中的对象、精灵、脚本、房间等资源。包含 GML 编码规范、文件格式、项目结构等。
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# GameMaker Studio 2 开发助手

你是 GameMaker Studio 2 项目的开发专家。当用户请求创建、修改 GameMaker 资源时，请遵循以下规范。

## 项目文件位置

项目根目录: `/Users/meishijie/GameMakerProjects/Platformer Template`

关键配置文件:
- 项目主文件: `Platformer Template.yyp`
- 文件夹定义: `folders/`
- 对象目录: `objects/`
- 精灵目录: `sprites/`
- 脚本目录: `scripts/`
- 房间目录: `rooms/`
- 序列目录: `sequences/`

## 资源命名规范

| 类型 | 前缀 | 示例 |
|------|------|------|
| 对象 | obj_ | obj_player, obj_coin |
| 精灵 | spr_ | spr_player_idle |
| 脚本 | scr_ | scr_collisions |
| 房间 | rm_ | rm_level_1 |
| 序列 | seq_ | seq_main_menu |
| 音效 | snd_ | snd_jump |

## 编码规范

### 变量命名
- 局部变量: snake_case (如 `local_x`, `move_speed`)
- 实例变量: 使用 `_` 前缀表示私有 (如 `_hp`)
- 布尔变量: is_, has_, can_ 开头

### 代码风格
- 缩进: 4 空格
- 最大行长度: 80 字符
- 注释: 使用 `//` 单行注释

### 事件文件命名
格式: `[EventType]_[EventNumber].gml`

| 事件类型 | 文件名示例 |
|---------|-----------|
| Create | Create_0.gml |
| Step | Step_0.gml, Step_1.gml, Step_2.gml |
| Collision | Collision_obj_enemy.gml |
| Keyboard | Keyboard_37.gml |
| Draw | Draw_0.gml |
| Alarm | Alarm_0.gml |

## 创建新资源流程

### 1. 创建目录结构

```
objects/obj_new_object/
├── obj_new_object.yy
└── Create_0.gml
```

### 2. 创建 .yy 配置文件

对象格式:
```json
{
  "$GMObject":"",
  "%Name":"obj_new_object",
  "eventList":[],
  "name":"obj_new_object",
  "spriteId":{"name":"spr_new_sprite","path":"sprites/spr_new_sprite/spr_new_sprite.yy",},
  "parentObjectId":{"name":"obj_character_parent","path":"objects/obj_character_parent/obj_character_parent.yy",},
  "resourceType":"GMObject",
  "resourceVersion":"2.0"
}
```

### 3. 注册到 .yyp

在 `Platformer Template.yyp` 的 `resources` 数组中添加:
```json
{"id":{"name":"obj_new_object","path":"objects/obj_new_object/obj_new_object.yy",},}
```

### 4. 继承关系设置

在对象的 .yy 文件中使用 `parentObjectId` 字段指定父对象:
- 玩家对象: `obj_character_parent`
- 敌人对象: `obj_enemy_parent`
- 方块对象: `obj_block_parent`
- 特效对象: `obj_effect_parent`

## 常用代码片段

### 继承父类事件
```gml
event_inherited();
```

### 创建实例
```gml
instance_create_layer(x, y, "Instances", obj_effect_jump);
```

### 播放音效
```gml
audio_play_sound(snd_jump, 0, 0);
```

### 随机音效音调
```gml
var _sound = audio_play_sound(snd_jump, 0, 0);
audio_sound_pitch(_sound, random_range(0.8, 1));
```

## 事件类型编号

| 事件类型 | 编号 |
|---------|------|
| Create | 0 |
| Destroy | 1 |
| Step | 2 |
| Collision | 4 |
| Keyboard | 5 |
| Mouse | 6 |
| Other | 7 |
| Draw | 8 |
| KeyPress | 9 |
| KeyRelease | 10 |

## 参考文档

- [文件格式参考](references/file-format.md)
- [对象配置格式](references/object-format.md)
- [精灵配置格式](references/sprite-format.md)

## 模板

- [创建新道具模板](templates/create-item.md)
- [创建新敌人模板](templates/create-enemy.md)
