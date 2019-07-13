# catalogue

## sql

**Oracle 11g2**  

* [Скрипт БД](./sql/db.sql)  
* [ER-диаграмма](./sql/UML_Catalogue.pdf)  

## Установка

### php
api разработано с помощью микрофреймворка Lumen

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

## api

### Товары

##### *Все товары*
Возвращает JSON-массив со всеми товарами   
**URL**: api/product/all  
**Method:** `GET`  
**URL Params:** отсутствуют  
**Success Response:** `[{"id":1,"name":"1234567890AAA01","caption":"Куртка","description":"Синяя куртка","price":1000,"quantity":2,"producttype_name":"clothes","producttype_caption":"одежда","orderQuantity":1,"photos":[{"id":3,"server":"http://catalogueApi/photos/","filename":"1234567890AAA012.jpg"}] }]`  
**Sample Call:** `javascript this.axios.get('api/product/all').then(response => { this.products = response.data;})`  

##### *Поиск товаров*
Поиск товаров по параметрам: наименование, минимальная цена, максимальная цена, тип товара.  

**URL**: api/product/search  
**Method:** `GET`  
**URL Params:** `caption/{caption}/pricemin/{pricemin}/pricemax/{pricemax}/producttype/{producttype}`  
При поиске без параметров `caption` или `producttype` используется значение `any`. Например `caption/any/`  
**Success Response:** `[{"id":1,"name":"1234567890AAA01","caption":"Куртка","description":"Синяя куртка","price":1000,"quantity":2,"producttype_name":"clothes","producttype_caption":"одежда","orderQuantity":1,"photos":[{"id":3,"server":"http://catalogueApi/photos/","filename":"1234567890AAA012.jpg"}] }]`  
**Sample Call:** `javascript this.axios.get('api/product/all').then(response => { this.products = response.data;})`  

##### *Категории товаров*  
Возвращает JSON-массив со всеми типами товаров

**URL**: api/producttype/all  
**Method:** `GET`  
**URL Params:** отсутствуют  
**Success Response:** `[{"id":1,"name":"casting","caption":"Литье"},{"id":2,"name":"clothes","caption":"Одежда"}]`  
**Sample Call:** `javascript this.axios.get('api/producttype/all').then(response => { this.productTypes = response.data;})`  

### Заказы

##### *Добавить заказ*
Добавляет заказ и его содержимое в бд, вовзращает id  
**URL**: api/order/new  
**Method:** `POST`  
**Params:** JSON-объект `{ "customerName":"ФИО заказчика", "customerPhone":"телефон заказчика", "opderProducts":[ {"id":<id товара>, "orderQuantity":<количество в заказе>} ] }`  
**Success Response:** `{ "idOrder" : 37 }`  
**Sample Call:** `javascript this.axios.post(
          this.apiPrefix + 'api/order/new', 
          newOrder,
          {headers: {'Content-Type': 'application/json',}})
          .then((response) => {
            this.apiResponse = response.data;
          })`  
