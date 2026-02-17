# 创建新敌人模板

## 步骤清单

1. [ ] 创建精灵目录和文件
2. [ ] 创建精灵配置文件 (.yy)
3. [ ] 创建对象目录和文件
4. [ ] 创建对象配置文件 (.yy)
5. [ ] 创建对象事件脚本 (.gml)
6. [ ] 创建战败对象
7. [ ] 更新项目文件 (.yyp)

## 对象配置模板

文件：`objects/obj_enemy_new/obj_enemy_new.yy`

```json
{
  "$GMObject":"",
  "%Name":"obj_enemy_new",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_enemy_new",
  "overriddenProperties":[],
  "parent":{
    "name":"Enemies",
    "path":"folders/Objects/Characters/Enemies.yy",
  },
  "parentObjectId":{
    "name":"obj_enemy_parent",
    "path":"objects/obj_enemy_parent/obj_enemy_parent.yy",
  },
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
    "name":"spr_enemy_new",
    "path":"sprites/spr_enemy_new/spr_enemy_new.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}
```

## Create 事件模板

文件：`objects/obj_enemy_new/Create_0.gml`

```gml
event_inherited();

// 设置战败对象
defeated_object = obj_enemy_new_defeated;

// 自定义属性
move_speed = 3;        // 移动速度
max_hp = 2;            // 最大生命值
hp = max_hp;
damage = 1;            // 对玩家伤害

// 随机初始方向
vel_x = choose(-move_speed, move_speed);
```

## 战败对象配置

文件：`objects/obj_enemy_new_defeated/obj_enemy_new_defeated.yy`

```json
{
  "$GMObject":"",
  "%Name":"obj_enemy_new_defeated",
  "eventList":[],
  "managed":true,
  "name":"obj_enemy_new_defeated",
  "overriddenProperties":[],
  "parent":{
    "name":"VFX",
    "path":"folders/Objects/VFX.yy",
  },
  "parentObjectId":{
    "name":"obj_effect_parent",
    "path":"objects/obj_effect_parent/obj_effect_parent.yy",
  },
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
    "name":"spr_enemy_new_defeated",
    "path":"sprites/spr_enemy_new_defeated/spr_enemy_new_defeated.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}
```

## 敌人属性参考

| 敌人类型 | move_speed | max_hp | damage |
|---------|------------|--------|--------|
| Enemy1 | 2 | 1 | 1 |
| Enemy2 | 4 | 2 | 2 |
| 自定义 | ? | ? | ? |
