# 精灵配置格式参考

## 精灵结构

精灵包含:
- `.yy` 配置文件
- 图像文件 (.png)

## .yy 配置文件字段

| 字段 | 类型 | 说明 |
|------|------|------|
| name | string | 精灵名称 |
| width | number | 精灵宽度 (像素) |
| height | number | 精灵高度 (像素) |
| originX | number | 原点 X |
| originY | number | 原点 Y |
| frames | array | 帧数组 |
| layers | array | 图层数组 |
| bboxMode | number | 包围盒模式 |
| collisionKind | number | 碰撞类型 |

## 包围盒模式 (bboxMode)

| 值 | 模式 |
|---|------|
| 0 | 自动 |
| 1 | 完整 |
| 2 | 手动 |
| 3 |  Precise |

## 碰撞类型 (collisionKind)

| 值 | 类型 |
|---|------|
| 0 | 矩形 |
| 1 | 圆形 |
| 2 | 菱形 |
| 3 | 智能 |
| 4 | 精确像素 |

## 原点 (origin)

| 值 | 位置 |
|---|------|
| 0 | 左上 |
| 1 | 顶部居中 |
| 2 | 右上 |
| 3 | 左侧居中 |
| 4 | 居中 |
| 5 | 右侧居中 |
| 6 | 左下 |
| 7 | 底部居中 |
| 8 | 右下 |

## 帧数组结构

```json
{
  "$GMSpriteFrame":"v1",
  "%Name":"uuid-string",
  "name":"uuid-string",
  "resourceType":"GMSpriteFrame",
  "resourceVersion":"2.0"
}
```

## 精灵尺寸建议

| 类型 | 建议尺寸 |
|------|---------|
| 玩家 | 64x64 ~ 128x128 |
| 敌人 | 32x32 ~ 64x64 |
| 道具 | 32x32 |
| 砖块 | 32x32 或 64x64 |
| 背景元素 | 视需求而定 |

## 纹理组

项目使用默认纹理组 `tg_game`。

```json
"textureGroupId":{
  "name":"tg_game",
  "path":"texturegroups/tg_game"
}
```
