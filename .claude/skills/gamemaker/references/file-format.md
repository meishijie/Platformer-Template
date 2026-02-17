# GameMaker 文件格式参考

## 资源文件格式 (.yy)

所有 GMS2 资源使用 JSON 格式的 `.yy` 配置文件。

## 对象 (.yy)

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
  "spriteMaskId":null,
  "visible":true,
  "solid":false,
  "persistent":false,
  "resourceType":"GMObject",
  "resourceVersion":"2.0"
}
```

## 精灵 (.yy)

```json
{
  "$GMSprite":"v2",
  "%Name":"spr_player_idle",
  "frames":[
    {"$GMSpriteFrame":"v1","%Name":"uuid-string","name":"uuid-string","resourceType":"GMSpriteFrame","resourceVersion":"2.0",}
  ],
  "layers":[
    {"$GMImageLayer":"","%Name":"uuid-string","blendMode":0,"displayName":"default","isLocked":false,"name":"uuid-string","opacity":100.0,"resourceType":"GMImageLayer","resourceVersion":"2.0","visible":true,}
  ],
  "name":"spr_player_idle",
  "origin":4,
  "height":154,
  "width":154,
  "bboxMode":2,
  "bbox_bottom":153,
  "bbox_left":32,
  "bbox_right":119,
  "bbox_top":38,
  "collisionKind":1,
  "parent":{
    "name":"Player",
    "path":"folders/Sprites/Player.yy",
  },
  "resourceType":"GMSprite",
  "resourceVersion":"2.0"
}
```

## 脚本 (.yy)

```json
{
  "$GMScript":"v1",
  "%Name":"scr_collisions",
  "isCompatibility":false,
  "isDnD":false,
  "name":"scr_collisions",
  "parent":{
    "name":"Scripts",
    "path":"folders/Scripts.yy",
  },
  "resourceType":"GMScript",
  "resourceVersion":"2.0",
}
```

## 文件夹 (.yy)

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

## 房间 (.yy)

```json
{
  "$GMRoom":"v1",
  "%Name":"rm_level_1",
  "creationCodeFile":"",
  "inheritCode":false,
  "inheritCreationOrder":false,
  "inheritLayers":false,
  "instanceCreationOrderIDs":[],
  "isDnd":false,
  "layers":[
    {"$GMRoomLayer":"","depth":0,"displayName":"Background","hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayers":false,"name":"Background","properties":[],"resourceType":"GMRoomLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true},
    {"$GMRoomLayer":"","depth":100,"displayName":"Instances","hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayers":false,"name":"Instances","properties":[],"resourceType":"GMRoomLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true},
    {"$GMRoomLayer":"","depth":200,"displayName":"Foreground","hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayers":false,"name":"Foreground","properties":[],"resourceType":"GMRoomLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true}
  ],
  "name":"rm_level_1",
  "parent":{
    "name":"Levels",
    "path":"folders/Rooms/Levels.yy",
  },
  "resourceType":"GMRoom",
  "resourceVersion":"2.0",
  "width":1280,
  "height":720
}
```

## UUID 格式

GMS2 使用 UUID v4 格式: `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`

### 生成 UUID (Python)
```python
import uuid
print(uuid.uuid4())  # 输出: 5c82d1ea-f7f1-49ad-b457-0dbec6104618
```

### 常见 UUID 类型

| 类型 | 字段名 |
|------|--------|
| 精灵帧 | `%Name` in `GMSpriteFrame` |
| 图层 | `%Name` in `GMImageLayer` |
| 事件 | `%Name` in `GMEvent` |

## .yyp 项目文件注册

在 `Platformer Template.yyp` 的 `resources` 数组中添加:

```json
{"id":{"name":"obj_new_object","path":"objects/obj_new_object/obj_new_object.yy",},}
```

resources 数组中的资源按字母顺序排列。
