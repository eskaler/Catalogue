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

    public function search($caption, $pricemin, $pricemax, $producttype){
        require "db.php";

        $conn = oci_connect($dbuser, $dbpassword, $dbname, $dbencoding);         
        if ( ! $conn ) { 
            echo "Невозможно подключится к базе: " . var_dump( OCIError() ); 
            die(); 
        } 

        $caption = $caption == "nocaption" ? "%%" : "%" . urldecode($caption) . "%";


        $producttype = $producttype == "any" ? "%%" : $producttype;

        // Производим выборку из базы данных 
        $products = oci_parse($conn, "
        select * from V_PRODUCTS products
        where
        LOWER(products.\"caption\") like LOWER(:caption) 
        and products.\"price\" >= :pricemin
        and products.\"price\" <= :pricemax
        and products.\"producttype_name\" like :producttype
         "); 
        oci_bind_by_name($products, ':caption', $caption);
        oci_bind_by_name($products, ':pricemin', $pricemin);
        oci_bind_by_name($products, ':pricemax', $pricemax);
        oci_bind_by_name($products, ':producttype', $producttype);
        oci_execute($products, OCI_DEFAULT); 

        $response = [];
        while(oci_fetch($products)){

            $photosOfProduct = oci_parse($conn, 
                "select * from V_PHOTOS where ID_PRODUCT = " . (int)oci_result($products, "id"));
            oci_execute($photosOfProduct, OCI_DEFAULT);
            $photos = [];
            while(oci_fetch($photosOfProduct)){
               $photos[] = [
                    'id' => (int)oci_result($photosOfProduct, "id"),
                    'server' => oci_result($photosOfProduct, "server"),
                    'filename' => oci_result($photosOfProduct, "filename")
               ];
            };

            $response[] = [
                'id' => (int)oci_result($products, "id"),
                'name' => oci_result($products, "name"),
                'caption' => oci_result($products, "caption"),
                'description' => oci_result($products, "description"),
                'price' => (float)oci_result($products, "price"),
                'quantity' => (int)oci_result($products, "quantity"),
                'producttype_name' => oci_result($products, "producttype_name"),
                'producttype_caption' => oci_result($products, "producttype_caption"),
                'orderQuantity' => 1,
                'photos' => $photos
            ];
        };
        return json_encode($response);
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
        $products = oci_parse($conn, "select * from V_PRODUCTS"); 
        oci_execute($products, OCI_DEFAULT); 

        $response = [];
        while(oci_fetch($products)){

            $photosOfProduct = oci_parse($conn, 
                "select * from V_PHOTOS where ID_PRODUCT = " . (int)oci_result($products, "id"));
            oci_execute($photosOfProduct, OCI_DEFAULT);
            $photos = [];
            while(oci_fetch($photosOfProduct)){
               $photos[] = [
                    'id' => (int)oci_result($photosOfProduct, "id"),
                    'server' => oci_result($photosOfProduct, "server"),
                    'filename' => oci_result($photosOfProduct, "filename")
               ];
            };

            $response[] = [
                'id' => (int)oci_result($products, "id"),
                'name' => oci_result($products, "name"),
                'caption' => oci_result($products, "caption"),
                'description' => oci_result($products, "description"),
                'price' => (float)oci_result($products, "price"),
                'quantity' => (int)oci_result($products, "quantity"),
                'producttype_name' => oci_result($products, "producttype_name"),
                'producttype_caption' => oci_result($products, "producttype_caption"),
                'orderQuantity' => 1,
                'photos' => $photos
            ];
        };
        return json_encode($response);
    }

    //
}
