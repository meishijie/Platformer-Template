# 创建新道具模板

## 步骤 1: 创建精灵

1. 在 `sprites/` 目录下创建新目录
2. 添加精灵图像文件
3. 创建 `.yy` 配置文件

## 精灵 .yy 示例

```json
{
  "$GMSprite":"v2",
  "%Name":"spr_mushroom",
  "frames":[
    {"$GMSpriteFrame":"v1","%Name":"生成uuid","name":"生成uuid","resourceType":"GMSpriteFrame","resourceVersion":"2.0",}
  ],
  "layers":[
    {"$GMImageLayer":"","%Name":"生成uuid","blendMode":0,"displayName":"default","isLocked":false,"name":"生成uuid","opacity":100.0,"resourceType":"GMImageLayer","resourceVersion":"2.0","visible":true,}
  ],
  "name":"spr_mushroom",
  "origin":4,
  "height":32,
  "width":32,
  "bboxMode":2,
  "parent":{
    "name":"Items",
    "path":"folders/Sprites/Items.yy"
  },
  "resourceType":"GMSprite",
  "resourceVersion":"2.0"
}
```

## 步骤 2: 创建对象

创建 `objects/obj_mushroom/` 目录，添加:

### obj_mushroom.yy
```json
{
  "$GMObject":"",
  "%Name":"obj_mushroom",
  "eventList":[],
  "name":"obj_mushroom",
  "spriteId":{"name":"spr_mushroom","path":"sprites/spr_mushroom/spr_mushroom.yy"},
  "visible":true,
  "solid":false,
  "resourceType":"GMObject",
  "resourceVersion":"2.0"
}
```

### Create_0.gml
```gml
// 道具初始化代码
// 例如: 浮动动画变量
float_offset = 0;
float_speed = 0.05;
float_amplitude = 3;
```

### Step_0.gml (可选)
```gml
// 浮动动画
float_offset += float_speed;
y = ystart + sin(float_offset) * float_amplitude;
```

## 步骤 3: 注册到 .yyp

在 `Platformer Template.yyp` 的 `resources` 数组中添加:

```json
{"id":{"name":"spr_mushroom","path":"sprites/spr_mushroom/spr_mushroom.yy",},}
{"id":{"name":"obj_mushroom","path":"objects/obj_mushroom/obj_mushroom.yy",},}
```

## 步骤 4: 添加玩家碰撞事件

在 `objects/obj_player/` 目录下创建 `Collision_obj_mushroom.gml`:

```gml
// 拾取道具逻辑
instance_create_layer(x, y - 20, "Instances", obj_mushroom_collect_effect);
audio_play_sound(snd_coin_collect_01, 0, 0);
instance_destroy(other);
```

## 步骤 5: 更新对象事件列表

在 `objects/obj_player/obj_player.yy` 的 `eventList` 中添加:

```json
{"$GMEvent":"v1","%Name":"","collisionObjectId":{"name":"obj_mushroom","path":"objects/obj_mushroom/obj_mushroom.yy",},"eventNum":0,"eventType":4,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
```
