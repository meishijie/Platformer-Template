# 精灵配置文件格式 (.yy)

## 基本结构

```json
{
  "$GMSprite":"v2",
  "%Name":"spr_name",
  "bboxMode":0,
  "bbox_bottom":63,
  "bbox_left":0,
  "bbox_right":63,
  "bbox_top":0,
  "collisionKind":1,
  "collisionTolerance":0,
  "DynamicTexturePage":false,
  "edgeFiltering":false,
  "For3D":false,
  "frames":[
    {"$GMSpriteFrame":"v1","%Name":"frame_guid","name":"frame_guid","resourceType":"GMSpriteFrame","resourceVersion":"2.0",},
  ],
  "gridX":0,
  "gridY":0,
  "height":64,
  "HTile":false,
  "layers":[
    {"$GMImageLayer":"","%Name":"layer_guid","blendMode":0,"displayName":"default","isLocked":false,"name":"layer_guid","opacity":100.0,"resourceType":"GMImageLayer","resourceVersion":"2.0","visible":true,},
  ],
  "name":"spr_name",
  "nineSlice":null,
  "origin":4,
  "parent":{
    "name":"Folder",
    "path":"folders/Sprites/Folder.yy",
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

## 文件目录结构

```
sprites/spr_name/
├── spr_name.yy                    # 精灵配置文件
├── <frame_guid_1>.png             # 帧图片（根目录）
├── <frame_guid_2>.png
└── layers/                        # 图层目录
    ├── <frame_guid_1>/
    │   └── <layer_guid>.png       # 图层图片
    └── <frame_guid_2>/
        └── <layer_guid>.png
```

## GUID 格式

精灵帧和图层使用 UUID 格式的 GUID：

```
示例：e60f348e-9d1a-4744-b2f6-54696129407b
```

## origin 值对照

| 值 | 原点位置 |
|----|---------|
| 0 | 左上角 |
| 1 | 中上 |
| 2 | 右上角 |
| 3 | 左中 |
| 4 | 中心 |
| 5 | 右中 |
| 6 | 左下角 |
| 7 | 中下 |
| 8 | 右下角 |

## bboxMode 值

| 值 | 模式 |
|----|------|
| 0 | 自动 |
| 1 | 全图 |
| 2 | 手动 |

## collisionKind 值

| 值 | 类型 |
|----|------|
| 0 | 精确 |
| 1 | 矩形 |
| 2 | 椭圆 |
| 3 | 菱形 |
