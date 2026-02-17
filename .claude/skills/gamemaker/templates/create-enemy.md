# 创建新敌人模板

## 概述

创建新敌人应该继承 `obj_enemy_parent`，这样可以获得:
- 自动巡逻 AI
- 悬崖检测
- 墙壁检测
- 受伤/死亡逻辑

## 步骤 1: 创建精灵

需要两个精灵:
- `spr_enemy_walk` - 行走动画
- `spr_enemy_idle` - 待机动画 (可选)
- `spr_enemy_defeated` - 死亡动画

### spr_enemy_new.yy 示例

```json
{
  "$GMSprite":"v2",
  "%Name":"spr_enemy_new",
  "frames":[
    {"$GMSpriteFrame":"v1","%Name":"生成uuid","name":"生成uuid","resourceType":"GMSpriteFrame","resourceVersion":"2.0",}
  ],
  "layers":[
    {"$GMImageLayer":"","%Name":"生成uuid","blendMode":0,"displayName":"default","isLocked":false,"name":"生成uuid","opacity":100.0,"resourceType":"GMImageLayer","resourceVersion":"2.0","visible":true,}
  ],
  "name":"spr_enemy_new",
  "origin":4,
  "height":32,
  "width":32,
  "bboxMode":0,
  "collisionKind":1,
  "parent":{
    "name":"Enemy1",
    "path":"folders/Sprites/Enemy1.yy"
  },
  "resourceType":"GMSprite",
  "resourceVersion":"2.0"
}
```

## 步骤 2: 创建活着的敌人

创建 `objects/obj_enemy_new/`:

### obj_enemy_new.yy
```json
{
  "$GMObject":"",
  "%Name":"obj_enemy_new",
  "eventList":[],
  "name":"obj_enemy_new",
  "parentObjectId":{
    "name":"obj_enemy_parent",
    "path":"objects/obj_enemy_parent/obj_enemy_parent.yy"
  },
  "spriteId":{
    "name":"spr_enemy_new",
    "path":"sprites/spr_enemy_new/spr_enemy_new.yy"
  },
  "resourceType":"GMObject",
  "resourceVersion":"2.0"
}
```

### Create_0.gml
```gml
// 调用父类初始化
event_inherited();

// 设置敌人属性
move_speed = 2;           // 移动速度
damage = 1;                // 对玩家造成的伤害
hp = 2;                    // 生命值
```

## 步骤 3: 创建死亡敌人 (可选)

敌人被踩死时显示的动画。

### obj_enemy_new_defeated.yy
```json
{
  "$GMObject":"",
  "%Name":"obj_enemy_new_defeated",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":7,"eventType":7,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
  ],
  "name":"obj_enemy_new_defeated",
  "parentObjectId":{
    "name":"obj_enemy_parent_defeated",
    "path":"objects/obj_enemy_parent_defeated/obj_enemy_parent_defeated.yy"
  },
  "spriteId":{
    "name":"spr_enemy_new_defeated",
    "path":"sprites/spr_enemy_new_defeated/spr_enemy_new_defeated.yy"
  },
  "resourceType":"GMObject",
  "resourceVersion":"2.0"
}
```

### Other_7.gml (动画结束销毁)
```gml
// 动画播放完毕后销毁
if (image_index >= image_number - 1) {
    instance_destroy();
}
```

## 步骤 4: 更新活着的敌人

在 `Create_0.gml` 中添加:
```gml
// 死亡后替换为死亡动画对象
defeated_object = obj_enemy_new_defeated;
```

## 步骤 5: 注册到 .yyp

```json
{"id":{"name":"spr_enemy_new","path":"sprites/spr_enemy_new/spr_enemy_new.yy",},}
{"id":{"name":"spr_enemy_new_defeated","path":"sprites/spr_enemy_new_defeated/spr_enemy_new_defeated.yy",},}
{"id":{"name":"obj_enemy_new","path":"objects/obj_enemy_new/obj_enemy_new.yy",},}
{"id":{"name":"obj_enemy_new_defeated","path":"objects/obj_enemy_new_defeated/obj_enemy_new_defeated.yy",},}
```

## 敌人属性参考

来自 `obj_enemy_parent`:

| 变量 | 默认值 | 说明 |
|------|--------|------|
| move_speed | 2 | 移动速度 |
| damage | 1 | 伤害值 |
| hp | 1 | 生命值 |
| vel_x | -2 或 2 | 当前水平速度 |
| friction_power | 0 | 摩擦力 (0=持续移动) |
