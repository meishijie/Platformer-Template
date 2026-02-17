# 对象配置文件格式 (.yy)

## 基本结构

```json
{
  "$GMObject":"",
  "%Name":"obj_name",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_name",
  "overriddenProperties":[],
  "parent":{
    "name":"ParentFolder",
    "path":"folders/ParentFolder.yy",
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
    "name":"spr_name",
    "path":"sprites/spr_name/spr_name.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}
```

## 事件类型对照表

| eventType | 事件名称 |
|-----------|---------|
| 0 | Create |
| 1 | Destroy |
| 2 | Alarm |
| 3 | Step |
| 4 | Collision |
| 5 | Keyboard |
| 6 | Mouse |
| 7 | Other |
| 8 | Draw |
| 9 | Key Press |
| 10 | Key Release |
| 11 | Trigger |
| 12 | Clean Up |
| 13 | Gesture |

## 常用事件配置

### Create 事件
```json
{"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
```

### Step 事件
```json
{"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
```

### Draw 事件
```json
{"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
```

### 碰撞事件
```json
{"$GMEvent":"v1","%Name":"","collisionObjectId":{"name":"obj_other","path":"objects/obj_other/obj_other.yy",},"eventNum":0,"eventType":4,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
```

### User Event 0 (事件号10)
```json
{"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":10,"eventType":7,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
```

### Alarm 事件
```json
{"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}
```

## 自定义属性

```json
"properties":[
  {"$GMObjectProperty":"v2","%Name":"property_name","filters":[],"listItems":[],"multiselect":false,"name":"property_name","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"1","varType":1,},
],
```

### varType 值

| 值 | 类型 |
|----|------|
| 0 | Real |
| 1 | Integer |
| 2 | String |
| 3 | Boolean |
| 4 | Expression |
| 5 | Resource |
| 6 | List |
