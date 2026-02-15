# Platformer Template `agent.md`

本文件用于约束后续 AI 在本仓库中的代码生成与文件生成行为，目标是：
- 正确理解项目架构（GameMaker + GML）
- 降低常见改动错误（事件顺序、继承、房间流转、资源生命周期）
- 让改动"最小、可回滚、可验证"

## 1. 项目快照（必须先读）

- **引擎/IDE**：GameMaker（`IDEVersion: 2024.14.3.217`，见 `Platformer Template.yyp`）
- **逻辑帧率**：`60`（见 `options/main/options_main.yy`）
- **关键房间顺序（`RoomOrderNodes`）**：
  1. `rm_menu` - 主菜单
  2. `rm_level_1` - 第一关
  3. `rm_level_2` - 第二关
  4. `rm_end` - 结束画面
- **关键单例对象**：
  - `obj_persistent_manager`（Persistent，创建全局粒子系统、播放背景音乐、设置音频监听器）
  - `obj_gamepad_input`（Persistent，维护手柄列表）
  - `obj_game_manager`（每个关卡房间 1 个，管理 HUD、暂停、碰撞 tilemap、环境音效）

## 2. 核心架构约束（硬规则）

### 2.1 角色与敌人继承链（不要破坏）

```
obj_character_parent (角色基类)
    │
    ├── obj_player (玩家)
    │       └── defeated → obj_player_defeated
    │
    └── obj_enemy_parent (敌人基类)
            │
            ├── obj_enemy1 (第一种敌人)
            │       └── defeated → obj_enemy1_defeated
            │
            └── obj_enemy2 (第二种敌人)
                    └── defeated → obj_enemy2_defeated
```

**obj_character_parent 核心职责**：
- 统一处理：重力、摩擦、像素级碰撞、受伤无敌帧、HP 归零替换
- 关键变量：`move_speed`, `jump_speed`, `grav_speed`, `friction_power`, `vel_x`, `vel_y`, `grounded`, `hp`, `max_hp`, `no_hurt_frames`, `defeated_object`

**obj_player 专属**：
- 输入标志（`left_input`/`right_input`/`jump_input`）
- 输入函数（`player_left()`/`player_right()`/`player_jump()`）
- 音频监听器位置、玩家状态机、玩家专属碰撞
- `in_knockback` 击退状态

**obj_enemy_parent 专属**：
- 自动巡逻（撞墙/悬崖/敌人互撞掉头）
- `damage` 伤害值属性

**obj_enemy1 vs obj_enemy2 对比**：

| 属性 | Enemy1 | Enemy2 |
|------|--------|--------|
| 移动速度 | 2 | 4 |
| 生命值 | 1 | 2 |
| 伤害值 | 1 | 2 |

**禁止**：在子对象事件里删除必要的 `event_inherited()`，否则会丢失父类核心逻辑。

### 2.2 Step 事件顺序依赖（强依赖）

当前项目依赖以下顺序：

| 事件 | 文件名 | 职责 |
|------|--------|------|
| Begin Step | `Step_1.gml` | 检测 `grounded`、存储上次地面位置、应用摩擦、应用重力 |
| Step | `Step_0.gml` | 像素级移动与碰撞推进（X轴优先，然后Y轴） |
| End Step | `Step_2.gml` | 朝向翻转、HP 检查与替换为 defeated_object、无敌帧闪烁 |

**禁止**：将父类 Begin Step/Step/End Step 逻辑挪到别的事件；不要改变这三段的职责边界。

### 2.3 碰撞系统约束（最容易被误改）

- **单一碰撞函数**：`scripts/scr_collisions/scr_collisions.gml` -> `check_collision(_move_x, _move_y)`
- **碰撞来源**：
  - 对象：`obj_collision` 及其子对象
  - 瓦片：`obj_game_manager.collision_tilemap`（来自图层名 `CollisionTiles`）
- **角色移动采用"逐像素推进 + 每像素检测"**：
  ```gml
  repeat (abs(vel_x)) {
      if (!check_collision(sign(vel_x), 0)) x += sign(vel_x);
      else { vel_x = 0; break; }
  }
  ```

**禁止**：
- 直接用 `x += vel_x` / `y += vel_y` 替代父类像素推进
- 修改/重命名关卡中的 `CollisionTiles` 图层
- 在无 `obj_game_manager` 的关卡放置可移动角色（会导致 tilemap 句柄缺失）

### 2.4 输入系统约束（键盘/手柄/触屏统一）

- **键盘、手柄、触屏事件只负责设置输入标志位**
- **真正执行移动/跳跃在 `obj_player/Step_1.gml` 调用 `player_left/right/jump()`**

**输入标志位**：
- `left_input` - 向左移动
- `right_input` - 向右移动
- `jump_input` - 跳跃

**键盘映射**：
- 方向键左/右：移动
- A/D 键：移动（WASD 支持）
- 空格键：跳跃

**禁止**：在离散输入事件里直接写位移逻辑，避免不同输入通道行为不一致。

### 2.5 暂停系统约束

`obj_game_manager` 通过：
- `instance_deactivate_all(true)` 暂停几乎所有实例
- `instance_activate_object(obj_gamepad_input)` 保留手柄恢复能力
- `layer_sequence_create(..., seq_pause_menu)` / `layer_sequence_destroy(...)` 管理暂停菜单

**暂停流程**：
1. 按 ESC 键触发 `KeyPress_27.gml`
2. 设置 `paused = true`
3. 停用所有实例（保留 game_manager 和 gamepad_input）
4. 创建暂停菜单序列
5. 再次按 ESC 恢复

**禁止**：
- 假设暂停时普通对象仍会继续 Step/Draw
- 把"必须在暂停时运行"的逻辑放到会被 deactive 的对象里

### 2.6 资源生命周期约束（防泄漏）

| 对象 | 创建资源 | 销毁位置 |
|------|----------|----------|
| `obj_gamepad_input` | `ds_list_create` | `CleanUp` 中 `ds_list_destroy` |
| `obj_persistent_manager` | `part_system_create_layer` | `CleanUp` 中 `part_system_destroy` |
| `obj_end_gate` | `audio_emitter_create` | `CleanUp` 中 `audio_emitter_free` |

**规则**：创建 DS/Emitter/Particle System 必须在可达的销毁路径释放。

### 2.7 玩家-敌人碰撞规则

**踩踏击败条件**（见 `obj_player/Collision_obj_enemy_parent.gml`）：
1. 玩家正在下落（`vel_y > 0`）
2. 玩家上一帧在敌人上方（`(bbox_bottom - vel_y) < (other.bbox_bottom - other.vel_y)`）

**被敌人伤害**：
- 扣除 `other.damage` 点 HP
- 击退：`vel_x = sign(x - other.x) * 15`
- 无敌帧：`no_hurt_frames = 120`（2秒）
- 击退持续：15 帧

## 3. 房间与图层规则（文件生成时必须遵守）

### 3.1 关卡房间最低配置

每个可游玩关卡（如 `rm_level_*`）至少应包含：
- `obj_game_manager`（单个）
- `obj_player`（或等价玩家入口）
- 瓦片图层 `CollisionTiles`
- 图层 `Instances`
- 图层 `TouchControlsLayer`（移动端/OperaGX 触控序列用）
- 图层 `EffectLeaf`（可选，叶子粒子效果）

### 3.2 房间流转

项目使用 `room_goto_next()`（如 `obj_player_end_level/Step_0.gml`），因此房间顺序受 `RoomOrderNodes` 控制。

**如果新增关卡**：
- 必须更新 `Platformer Template.yyp` 的 `RoomOrderNodes`
- 新关卡应插在 `rm_end` 之前

### 3.3 图层命名约定

| 图层名 | 用途 |
|--------|------|
| `Instances` | 主要实例层 |
| `CollisionTiles` | 碰撞瓦片层（必须存在） |
| `TouchControlsLayer` | 触控按钮层 |
| `EffectLeaf` | 叶子粒子效果层 |

## 4. 文件编辑策略（降低损坏概率）

### 4.1 优先编辑文件

优先改：
- `objects/**/**.gml` - 事件脚本
- `scripts/**/*.gml` - 全局脚本
- 文档（`*.md` / `notes/*`）

### 4.2 高风险文件（谨慎改）

高风险：
- `Platformer Template.yyp` - 项目配置
- `rooms/**/*.yy` - 含大量压缩 tile 数据
- `objects/**/obj_*.yy` - 事件映射、继承、属性

原则：
- 仅做最小差异改动
- 不做无关字段重排
- 不手改与目标无关的大块 tile 数据

### 4.3 事件文件命名约定（新增事件时）

本项目实际命名模式：

| 事件类型 | 文件名 | 说明 |
|----------|--------|------|
| Create | `Create_0.gml` | 创建事件 |
| Step | `Step_0.gml` | 主 Step 事件 |
| Begin Step | `Step_1.gml` | 开始 Step |
| End Step | `Step_2.gml` | 结束 Step |
| Key Press | `KeyPress_<keycode>.gml` | 按键按下（如 27=ESC, 32=Space, 82=R） |
| Key Down | `Keyboard_<keycode>.gml` | 按键按住（如 37=左, 39=右, 65=A, 68=D） |
| Collision | `Collision_<object>.gml` | 碰撞事件 |
| Alarm | `Alarm_<n>.gml` | 闹钟事件 |
| Room Start | `Other_4.gml` | 房间开始 |
| Room End | `Other_5.gml` | 房间结束 |
| Animation End | `Other_7.gml` | 动画结束 |
| User Event 0 | `Other_10.gml` | 用户事件 0 |
| Async - System | `Other_75.gml` | 异步系统事件 |
| Broadcast Message | `Other_76.gml` | 广播消息 |
| Clean Up | `CleanUp_0.gml` | 清理事件 |
| Draw | `Draw_0.gml` | 绘制事件 |
| Draw GUI | `Draw_64.gml` | GUI 绘制事件 |

**规则**：新增事件必须与对应对象 `.yy` 的 `eventList` 一一匹配。

## 5. 代码风格（按当前项目一致性）

- 使用 GML 2.3+ 风格（函数、结构体语法可用）
- 局部临时变量采用 `var _name`（与现有代码一致）
- 尽量在已有对象/脚本扩展，不无故新增大量资源
- 对跨实例访问先做 `instance_exists(...)` 防御
- 使用 `with (...)` 时，明确当前作用域；需要外层实例时使用 `other`
- 保持注释解释"为什么"，不要只解释"做了什么"
- 函数定义使用匿名函数语法：
  ```gml
  player_jump = function() {
      // 函数体
  };
  ```

## 6. 常见错误清单（AI 必须规避）

1. ❌ 忘记 `event_inherited()`，导致父类移动/重力/HP 逻辑丢失。
2. ❌ 重命名 `CollisionTiles` 或 `Instances` 图层，导致运行时取层失败。
3. ❌ 在关卡里放多个 `obj_game_manager`，引发对象变量访问不确定性。
4. ❌ 新增房间但没更新 `RoomOrderNodes`，`room_goto_next()` 流程错误。
5. ❌ 创建 DS/Emitter/Particle 后不释放，导致泄漏或跨房间污染。
6. ❌ 在输入事件里直接改位移，破坏键盘/手柄/触屏一致行为。
7. ❌ 在会被 `instance_deactivate_all` 停用的对象里放"暂停期必须运行"的代码。
8. ❌ 手改 `.yy` 时误改无关字段或大块 tile 压缩数据，造成难以合并和回退。
9. ❌ 在敌人 Create 事件中重复设置 `vel_x` 时使用错误的随机方向（如 `choose(-move_speed, -move_speed)` 应为 `choose(-move_speed, move_speed)`）。

## 7. 任务模板（建议执行顺序）

### 7.1 新增敌人

1. 基于 `obj_enemy_parent` 创建新对象。
2. 在 Create 事件调用 `event_inherited()` 后覆写参数：
   ```gml
   event_inherited();
   defeated_object = obj_enemyX_defeated;
   move_speed = X;
   max_hp = X;
   hp = max_hp;
   damage = X;
   vel_x = choose(-move_speed, move_speed);
   ```
3. 需要特殊行为再增 Step/End Step 逻辑，避免复制父类整段移动代码。
4. 配置 `defeated_object` 并保证动画对象可自销毁。
5. 进房间实测踩踏、受伤、转向、掉落、销毁流程。

### 7.2 新增可站立地形对象

1. 对象继承 `obj_collision`（或其子类）。
2. 仅添加必要视觉/交互逻辑，不改动 `check_collision` 总入口。
3. 进房间验证角色站立、贴边、跳跃顶碰。

### 7.3 新增关卡

1. 复制现有关卡房间结构（图层名保持一致）。
2. 放置 `obj_game_manager` 与玩家出生点。
3. 确认存在 `CollisionTiles`。
4. 更新 `RoomOrderNodes`，确保 `room_goto_next()` 路径正确。
5. 从 `rm_menu` 全流程跑到新关卡与 `rm_end`。

### 7.4 新增可击碎方块

1. 继承 `obj_block_parent`。
2. 实现 `Collision_obj_player.gml` 处理玩家头顶碰撞。
3. 设置 `hit_count` 或直接销毁逻辑。
4. 创建对应的 defeated/destroy 动画对象。

## 8. 提交前自检

- [ ] 是否保留了所有必要 `event_inherited()`？
- [ ] 是否仍只有一个活动的 `obj_game_manager`（每个关卡）？
- [ ] 是否未破坏 `CollisionTiles` / `Instances` / `TouchControlsLayer` / `EffectLeaf` 图层名？
- [ ] 是否所有新建 DS/Emitter/Particle 均有释放路径？
- [ ] 是否 `room_goto_next()` 对应的房间顺序正确？
- [ ] 是否输入行为在键盘与手柄下都一致？
- [ ] 是否敌人 `vel_x` 初始化使用了正确的随机方向？

## 9. 项目资源清单

### 9.1 对象分组

| 分组 | 说明 |
|------|------|
| Characters | 角色基类、玩家、敌人 |
| Environment | 碰撞对象、方块、交互物品、收集品 |
| HUD | 游戏界面元素（金币、生命值显示） |
| Managers | 游戏管理器、手柄输入、持久化管理器 |
| UI | 按钮、菜单 |
| VFX | 视觉特效（灰尘、跳跃效果等） |

### 9.2 序列资源

| 序列名 | 用途 |
|--------|------|
| `seq_game_hud` | 游戏内 HUD 界面 |
| `seq_game_over` | 游戏结束画面 |
| `seq_main_menu` | 主菜单界面 |
| `seq_pause_menu` | 暂停菜单界面 |
| `seq_touch_controls` | 触控按钮布局 |

### 9.3 脚本

| 脚本名 | 函数 | 说明 |
|--------|------|------|
| `scr_collisions` | `check_collision(_move_x, _move_y)` | 检测对象和瓦片碰撞 |

### 9.4 音频资源

| 类型 | 示例 |
|------|------|
| 音乐 | `snd_music_level`, `snd_music_lose` |
| 环境音 | `snd_amb_cave_01`, `snd_amb_trees`, `snd_amb_wind` |
| 音效 | `snd_jump`, `snd_coin_collect_01`, `snd_enemy_hit`, `snd_footstep_*` |

## 10. 官方参考（编写本规范依据）

- GML 总览：[GML Overview](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/GML_Overview.htm)
- 脚本函数语法：[Script Functions And Variables](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Script_Properties/Script_Functions.htm)
- 对象事件：[Object Events](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Object_Properties/Object_Events.htm)
- Begin Step：[Begin Step](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Object_Properties/Object_Events/Step_Events/Begin_Step.htm)
- Step：[Step](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Object_Properties/Object_Events/Step_Events/Step.htm)
- End Step：[End Step](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Object_Properties/Object_Events/Step_Events/End_Step.htm)
- 继承事件：[Inherit Event / event_inherited](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Object_Properties/Object_Events/Inherit_Event.htm)
- 作用域切换：[with](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Overview/Language_Features/with.htm)
- 实例存在判断：[instance_exists](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/instance_exists.htm)
- 实例停用机制：[Instance Deactivation](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Deactivation/Instance_Deactivation.htm)
- Tilemap 获取：[layer_tilemap_get_id](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Rooms/Tile_Map_Layers/layer_tilemap_get_id.htm)
- 瓦片像素查询：[tilemap_get_at_pixel](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Rooms/Tile_Map_Layers/tilemap_get_at_pixel.htm)
- 碰撞检测函数：[place_meeting](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Movement_And_Collisions/Collisions/place_meeting.htm)
- 序列图层创建/销毁：[layer_sequence_create](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Rooms/Sequence_Layers/layer_sequence_create.htm), [layer_sequence_destroy](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Rooms/Sequence_Layers/layer_sequence_destroy.htm)
- 房间顺序与切换：[Room Manager](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Room_Manager.htm), [room_goto_next](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Rooms/room_goto_next.htm)
- DS List 生命周期：[ds_list_create](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Data_Structures/DS_Lists/ds_list_create.htm), [ds_list_destroy](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Data_Structures/DS_Lists/ds_list_destroy.htm)
- 粒子系统生命周期：[part_system_create_layer](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Particles/Particle_Systems/part_system_create_layer.htm), [part_system_destroy](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Particles/Particle_Systems/part_system_destroy.htm)
- Source Control 与冲突处理：[Source Control](https://manual.gamemaker.io/lts/en/IDE_Tools/Source_Control.htm), [Conflicts](https://manual.gamemaker.io/lts/en/IDE_Tools/Source_Control/Conflicts.htm)

---

如果后续 AI 任务与本文件冲突：优先遵守用户明确需求，其次保持本项目运行链路不被破坏（事件顺序、碰撞链路、房间顺序、资源释放）。
