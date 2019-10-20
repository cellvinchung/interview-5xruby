# 五倍紅寶石題目

## model關係圖

![model關係圖](https://i.imgur.com/A1kIvJz.jpg)

## table schema

### model: User

|欄位名稱|資料形態|
|--|--|
|name|string|
|email|string|
|password|string|

### model: Mission

|欄位名稱|資料形態|
|--|--|
|user_id|integer|
|name|string|
|start_at|datetime|
|end_at|datetime|
|priority|integer|
|status|integer|
|content|text|

### model: Tag

|欄位名稱|資料形態|
|--|--|
|name|string|

### model: MissionTag

|欄位名稱|資料形態|
|--|--|
|tag_id|integer|
|mission_id|integer|
