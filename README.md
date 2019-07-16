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

<details>
          <summary> Товары </summary>

##### *Все товары*
Возвращает JSON-массив со всеми товарами   
**URL**: api/product/all  
**Method:** `GET`  
**URL Params:** отсутствуют  
**Success Response:** `[{"id":1,"name":"1234567890AAA01","caption":"Куртка","description":"Синяя куртка","price":1000,"quantity":2,"producttype_name":"clothes","producttype_caption":"одежда","orderQuantity":1,"photos":[{"id":3,"server":"http://catalogueApi/photos/","filename":"1234567890AAA012.jpg"}] }]`  

##### *Поиск товаров*  
Поиск товаров по параметрам: наименование, минимальная цена, максимальная цена, тип товара.  
**URL**: api/product/search  
**Method:** `GET`  
**URL Params:** `caption/{caption}/pricemin/{pricemin}/pricemax/{pricemax}/producttype/{producttype}`  
При поиске без параметров `caption` или `producttype` используется значение `any`. Например `caption/any/`  
**Success Response:** `[{"id":1,"name":"1234567890AAA01","caption":"Куртка","description":"Синяя куртка","price":1000,"quantity":2,"producttype_name":"clothes","producttype_caption":"одежда","orderQuantity":1,"photos":[{"id":3,"server":"http://catalogueApi/photos/","filename":"1234567890AAA012.jpg"}] }]`  

##### *Добавить товар*  
Добавляет товар, возвращает id  
**URL**: api/product/new  
**Method:** `POST`  
**URL Params:** JSON-объект  `{ "apiKey" : <ключ API>, "name" : <артикул>, "caption" : <Наименование>, "description" : <описание>, "quantity" : <количество товара>, "price" : <цена>, "producttype_id" : <id категории товара> }`    
**Success Response:** `{"idNewProduct" : 4 }`  

##### *Изменить категорию товаров*  
Изменяет товар, возвращает id  
**URL**: api/product/update  
**Method:** `POST`  
**URL Params:** JSON-объект  `{ "apiKey" : <ключ API>, "id" : <id товара>, "name" : <артикул>, "caption" : <Наименование>, "description" : <описание>, "quantity" : <количество товара>, "price" : <цена>, "producttype_id" : <id категории товара> }`    
**Success Response:** `success` 

</details>

<details>
          <summary>Категории товаров</summary>
          
##### *Категории товаров*  
Возвращает JSON-массив со всеми типами товаров  
**URL**: api/producttype/all  
**Method:** `GET`  
**URL Params:** отсутствуют  
**Success Response:** `[{"id":1,"name":"casting","caption":"Литье"},{"id":2,"name":"clothes","caption":"Одежда"}]`  

##### *Добавить категорию товаров*  
Добавляет категорию товаров, возвращает id  
**URL**: api/producttype/new  
**Method:** `POST`  
**URL Params:** JSON-объект  `{ "apiKey" : <ключ API>, "name" : <системное название>, "caption" : <Наименование> }`    
**Success Response:** `{"idNewProductType" : 4 }`  

##### *Изменить категорию товаров*  
Изменяет категорию товаров  
**URL**: api/producttype/update  
**Method:** `POST`  
**URL Params:** JSON-объект  `{ "apiKey" : <ключ API>, "id" : <id категории>, "name" : <системное название>, "caption" : <Наименование> }`    
**Success Response:** `success`  
          
</details>

<details>
<summary>Заказы</summary
          
##### *Добавить заказ*  
Добавляет заказ и его содержимое, вовзращает id  
**URL**: api/order/new  
**Method:** `POST`  
**Params:** JSON-объект `{ "customerName":"ФИО заказчика", "customerPhone":"телефон заказчика", "opderProducts":[ {"id":<id товара>, "orderQuantity":<количество в заказе>} ] }`  
**Success Response:** `{ "idOrder" : 37 }`  

##### *Все заказы*  
Возвращает список заказов с товарами  
**URL**: api/order/all  
**Method:** `POST`  
**Params:** JSON-объект  `{ "apiKey" : <ключ API> }`  
**Success Response:** `[{"id":28,"customerName":"Андреева Стела Робертовна ","customerPhone":"89688715982","created":"16.07.19","idOrderState":1,"orderStateCaption":"Новый","expires":"31.07.19","products":[{"id":32,"idProduct":9,"orderQuantity":1,"name":"1335276","caption":"Кресло офисное Бюрократ CH-1201NX","price":1800,"photo":"http://localhost:8000/photos/стулбюрократ1.jpg"},{"id":33,"idProduct":4,"orderQuantity":3,"name":"15536868","caption":"Светоотражающий жилет","price":200,"photo":"http://localhost:8000/photos/жилет1.jpg"}]}]`  

#### *Отменить заказ*  
Устанавливает заказу статус Отменен  
**URL**: api/order/cancel  
**Method:** `POST`  
**Params:** JSON-объект `{ "apiKey" : <ключ API>, "id" : <id заказа> }`  
**Success Response:** `success`  

#### *Оплатить заказ*  
Устанавливает заказу статус Оплачен  
**URL**: api/order/pay  
**Method:** `POST`  
**Params:** JSON-объект `{ "apiKey" : <ключ API>, "id" : <id заказа> }`  
**Success Response:** `success`  

#### *Продлить заказ*  
Добавляет 15 дней к дате истечения заказа  
**URL**: api/order/prolong  
**Method:** `POST`  
**Params:** JSON-объект `{ "apiKey" : <ключ API>, "id" : <id заказа> }`  
**Success Response:** `success`  

</details>

<details>
<summary>Авторизация</summary>  
          
#### *Авторизоваться*  
Проверяет правильность логина и пароля, в случае успеха заносит в таблицу случайный API ключ  
**URL**: api/auth/signin  
**Method:** `POST`  
**Params:** JSON-объект `{ "login" : <логин>, "password" : <пароль> }`  
**Success Response:** `{ "apiKey" : "SjdVTERrM3o5ZlhDRHg3dnVmcmo5cXoxRnQxMDRhTmFuUmcyODdvbA==" }`  
</details>
