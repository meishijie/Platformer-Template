# 创建新道具模板

## 步骤清单

1. [ ] 创建精灵目录和文件
2. [ ] 创建精灵配置文件 (.yy)
3. [ ] 创建对象目录和文件
4. [ ] 创建对象配置文件 (.yy)
5. [ ] 创建对象事件脚本 (.gml)
6. [ ] 更新玩家碰撞事件
7. [ ] 更新项目文件 (.yyp)

## 文件创建脚本

```bash
# 设置道具名称
ITEM_NAME="obj_new_item"
SPRITE_NAME="spr_new_item"

# 创建目录
mkdir -p "sprites/${SPRITE_NAME}"
mkdir -p "sprites/${SPRITE_NAME}/layers"
mkdir -p "objects/${ITEM_NAME}"
```

## 精灵配置模板

文件：`sprites/spr_item/spr_item.yy`

```json
{
  "$GMSprite":"v2",
  "%Name":"spr_item",
  "bboxMode":0,
  "bbox_bottom":60,
  "bbox_left":4,
  "bbox_right":60,
  "bbox_top":4,
  "collisionKind":1,
  "collisionTolerance":0,
  "DynamicTexturePage":false,
  "edgeFiltering":false,
  "For3D":false,
  "frames":[],
  "gridX":0,
  "gridY":0,
  "height":64,
  "HTile":false,
  "layers":[
    {"$GMImageLayer":"","%Name":"layer_guid","blendMode":0,"displayName":"default","isLocked":false,"name":"layer_guid","opacity":100.0,"resourceType":"GMImageLayer","resourceVersion":"2.0","visible":true,},
  ],
  "name":"spr_item",
  "nineSlice":null,
  "origin":4,
  "parent":{
    "name":"Items",
    "path":"folders/Sprites/Items.yy",
  },
  "preMultiplyAlpha":false,
  "resourceType":"GMSprite",
  "resourceVersion":"2.0",
  "sequence":{...},
  "swatchColours":null,
  "swfPrecision":2.525,
  "textureGroupId":{
    "name":"tg_game",
    "path":"texturegroups/tg_game",
  },
  "type":0,
  "VTile":false,
  "width":64,
}
```

## 对象配置模板

文件：`objects/obj_item/obj_item.yy`

```json
{
  "$GMObject":"",
  "%Name":"obj_item",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_item",
  "overriddenProperties":[],
  "parent":{
    "name":"Items",
    "path":"folders/Objects/Environment/Items.yy",
  },
  "parentObjectId":null,
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":{
    "name":"spr_item",
    "path":"sprites/spr_item/spr_item.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}
```

## Create 事件模板

文件：`objects/obj_item/Create_0.gml`

```gml
// 随机动画起始帧
image_index = irandom_range(0, image_number - 1);
```

## 玩家碰撞事件模板

文件：`objects/obj_player/Collision_obj_item.gml`

```gml
// 道具效果逻辑
// TODO: 添加具体效果

// 创建收集特效
instance_create_layer(other.x, other.y, "Instances", obj_collect_effect);

// 播放音效
audio_play_sound(snd_coin_collect_01, 0, 0);

// 销毁道具
instance_destroy(other);
```

## 项目文件更新

在 `Platformer Template.yyp` 的 resources 数组中添加：

```json
{"id":{"name":"spr_item","path":"sprites/spr_item/spr_item.yy",},},
{"id":{"name":"obj_item","path":"objects/obj_item/obj_item.yy",},},
```

在 `objects/obj_player/obj_player.yy` 的 eventList 中添加：

```json
{"$GMEvent":"v1","%Name":"","collisionObjectId":{"name":"obj_item","path":"objects/obj_item/obj_item.yy",},"eventNum":0,"eventType":4,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
```
