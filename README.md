# catalogue

## api

###Товары

##### *Все товары*
Возвращает JSON-массив со всеми товарами  
**URL**: /products/  
**Method:** `GET`  
**URL Params:** отсутствуют  
**Success Response:** `[{"id":"1","name":"1234567890AAA01","caption":"Куртка","description":"Синяя куртка","price":"1000","quantity":"2","producttype_name":"clothes","producttype_caption":"одежда","orderQuantity":1,"photos":[{"id":"3","server":"http://catalogueApi/photos/","filename":"1234567890AAA012.jpg"}`  
**Sample Call:** `javascript this.axios.get('/products/').then(response => { this.products = response.data;})`  

## Установка

### php
Для работы требуется 

- php 7.1 
- OCI8

Содержимое [/api](api) размещается в корне сервера

### nmp
Установка проекта
```
npm install 
```

Запуск для разработки
```
npm run serve
```

Компиляция для продакшна
```
npm run build
```

