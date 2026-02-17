# 对象配置格式参考

## 对象结构

GameMaker 对象包含:
- `.yy` 配置文件
- 事件代码文件 (Create_0.gml, Step_0.gml 等)

## .yy 配置文件字段

| 字段 | 类型 | 说明 |
|------|------|------|
| name | string | 对象名称 (不含前缀) |
| parentObjectId | object | 父对象引用 |
| spriteId | object | 默认精灵引用 |
| spriteMaskId | object | 碰撞遮罩精灵 |
| solid | boolean | 是否为实体 |
| visible | boolean | 是否可见 |
| persistent | boolean | 是否跨房间持久 |
| eventList | array | 事件列表 |

## 事件列表结构

```json
{
  "$GMEvent":"v1",
  "%Name":"",
  "collisionObjectId":{"name":"obj_enemy","path":"objects/obj_enemy/obj_enemy.yy",},
  "eventNum":0,
  "eventType":4,
  "isDnD":false,
  "name":"",
  "resourceType":"GMEvent",
  "resourceVersion":"2.0"
}
```

## 事件类型编号

| eventType | 事件 |
|-----------|------|
| 0 | Create |
| 1 | Destroy |
| 2 | Step (0=Step, 1=Begin Step, 2=End Step) |
| 3 | Alarm |
| 4 | Collision |
| 5 | Keyboard |
| 6 | Mouse |
| 7 | Other |
| 8 | Draw |
| 9 | KeyPress |
| 10 | KeyRelease |
| 12 | Async |

## 常用父对象

| 父对象 | 用途 |
|--------|------|
| obj_character_parent | 玩家和敌人基类 |
| obj_enemy_parent | 敌人基类 |
| obj_block_parent | 可碰撞方块 |
| obj_effect_parent | 特效 |
| obj_button_parent | UI 按钮 |

## 事件文件命名

碰撞事件格式: `Collision_[对象名].gml`

例如:
- `Collision_obj_coin.gml` - 与金币碰撞
- `Collision_obj_enemy_parent.gml` - 与敌人碰撞
