<?php

namespace App\Http\Controllers;

class ProductController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function all(){
        require "db.php";
        //временно

        $conn = OCILogon($dbuser, $dbpassword, $dbname, $dbencoding);         
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
                    'id' => (int)ociresult($photosOfProduct, "id"),
                    'server' => ociresult($photosOfProduct, "server"),
                    'filename' => ociresult($photosOfProduct, "filename")
               ];
            };

            $response[] = [
                'id' => (int)ociresult($products, "id"),
                'name' => ociresult($products, "name"),
                'caption' => ociresult($products, "caption"),
                'description' => ociresult($products, "description"),
                'price' => (float)ociresult($products, "price"),
                'quantity' => (int)ociresult($products, "quantity"),
                'producttype_name' => ociresult($products, "producttype_name"),
                'producttype_caption' => ociresult($products, "producttype_caption"),
                'orderQuantity' => 1,
                'photos' => $photos
            ];
        };
        return json_encode($response);
    }

    //
}
