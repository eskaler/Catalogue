<?php


// Роутер
function route($method, $urlData, $formData) {
    require "db.php";
    //временно
    header('Access-Control-Allow-Origin: *');

    //получение всех товаров
    // products/
    if ($method === 'GET') {
        
        $conn = ocilogon($dbuser, $dbpassword, $dbname, $dbencoding);         
        if ( ! $conn ) { 
            echo "Невозможно подключится к базе: " . var_dump( OCIError() ); 
            die(); 
        } 
        // Производим выборку из базы данных 
        $products = OCIParse($conn, "select * from V_PRODUCTS"); 
        OCIExecute($products, OCI_DEFAULT); 

        $response = [];
        while(OCIFetch($products)){

            $photosOfProduct = OCIParse($conn, 
                "select * from V_PHOTOS where ID_PRODUCT = " . (int)ociresult($products, "id"));
            OCIExecute($photosOfProduct, OCI_DEFAULT);
            $photos = [];
            while(OCIFetch($photosOfProduct)){
               $photos[] = [
                    'id' => ociresult($photosOfProduct, "id"),
                    'server' => ociresult($photosOfProduct, "server"),
                    'filename' => ociresult($photosOfProduct, "filename")
               ];
            };

            $response[] = [
                'id' => ociresult($products, "id"),
                'name' => ociresult($products, "name"),
                'caption' => ociresult($products, "caption"),
                'description' => ociresult($products, "description"),
                'price' => ociresult($products, "price"),
                'quantity' => ociresult($products, "quantity"),
                'producttype_name' => ociresult($products, "producttype_name"),
                'producttype_caption' => ociresult($products, "producttype_caption"),
                'orderQuantity' => 1,
                'photos' => $photos
            ];
        };
        echo json_encode($response);

        return;
    }

    /*
    // Получение информации о товаре
    // GET /goods/{goodId}
    if ($method === 'GET' && count($urlData) === 1) {
        // Получаем id товара
        $goodId = $urlData[0];

        // Вытаскиваем товар из базы...

        // Выводим ответ клиенту
        echo json_encode(array(
            'method' => 'GET',
            'id' => $goodId,
            'good' => 'phone',
            'price' => 10000
        ));

        return;
    }


    // Добавление нового товара
    // POST /goods
    if ($method === 'POST' && empty($urlData)) {
        // Добавляем товар в базу...

        // Выводим ответ клиенту
        echo json_encode(array(
            'method' => 'POST',
            'id' => rand(1, 100),
            'formData' => $formData
        ));
        
        return;
    }


    // Обновление всех данных товара
    // PUT /goods/{goodId}
    if ($method === 'PUT' && count($urlData) === 1) {
        // Получаем id товара
        $goodId = $urlData[0];

        // Обновляем все поля товара в базе...

        // Выводим ответ клиенту
        echo json_encode(array(
            'method' => 'PUT',
            'id' => $goodId,
            'formData' => $formData
        ));

        return;
    }


    // Частичное обновление данных товара
    // PATCH /goods/{goodId}
    if ($method === 'PATCH' && count($urlData) === 1) {
        // Получаем id товара
        $goodId = $urlData[0];

        // Обновляем только указанные поля товара в базе...

        // Выводим ответ клиенту
        echo json_encode(array(
            'method' => 'PATCH',
            'id' => $goodId,
            'formData' => $formData
        ));

        return;
    }


    // Удаление товара
    // DELETE /goods/{goodId}
    if ($method === 'DELETE' && count($urlData) === 1) {
        // Получаем id товара
        $goodId = $urlData[0];

        // Удаляем товар из базы...

        // Выводим ответ клиенту
        echo json_encode(array(
            'method' => 'DELETE',
            'id' => $goodId
        ));
        
        return;
    }

*/
    // Возвращаем ошибку
    header('HTTP/1.0 400 Bad Request');
    echo json_encode(array(
        'error' => 'Bad Request'
    ));

}
