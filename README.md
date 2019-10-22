# 五倍紅寶石題目

[![Build Status](https://travis-ci.org/cellvinchung/interview-5xruby.svg?branch=topic)](https://travis-ci.org/cellvinchung/interview-5xruby)

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

## 版本

- ruby: 2.6.0
- rails: 6.0.0

## 部署至heroku

- 登入

```bash
    heroku login
```

- 準備

```bash
    heroku create interview-5xruby
```

- 新增remote heroku節點

```bash
    git remote add heroku https://git.heroku.com/interview-5xruby.git
```

- 部署

```bash
    git push heroku master

    #migration有變動時
    heroku run rails db:migrate
```