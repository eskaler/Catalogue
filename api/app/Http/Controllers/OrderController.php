<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

function apiKeyIsValid($apiKey){
  require "db.php";
  $conn = oci_connect($dbuser, $dbpassword, $dbname, $dbencoding);         
    if ( ! $conn ) { 
        echo "Невозможно подключится к базе: " . var_dump( OCIError() ); 
        die(); 
    } 
  
  $query = "BEGIN :idUser := CRM_USER_APIKEY_ISVALID(:apikey); END;";
  $getUser = OCIParse($conn, $query);
  oci_bind_by_name($getUser, ':apikey', $apiKey);
  oci_bind_by_name($getUser, ':idUser', $idUser);
  
  oci_execute($getUser, OCI_DEFAULT);

  return $idUser;
}

class OrderController extends Controller
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

    public function all(Request $request){
      require "db.php";
      $conn = oci_connect($dbuser, $dbpassword, $dbname, $dbencoding);         
      if ( ! $conn ) { 
          echo "Невозможно подключится к базе: " . var_dump( OCIError() ); 
          die(); 
      } 

      $apiKey = $request->input('apiKey');
      
      if(apiKeyIsValid($apiKey) != 0){
        $orders = oci_parse($conn, "
          select * from V_ORDERS"); 
        oci_execute($orders, OCI_DEFAULT); 

        $response = [];
        while(oci_fetch($orders)){

            $productsInOrder = oci_parse($conn, 
                "select * from V_ORDERPRODUCTS where \"id\" = " . (int)oci_result($orders, "id"));
            oci_execute($productsInOrder, OCI_DEFAULT);
            $products = [];
            while(oci_fetch($productsInOrder)){
               $products[] = [
                    'id' => (int)oci_result($productsInOrder, "id"),
                    'idProduct' => oci_result($productsInOrder, "idProduct"),
                    'quantity' => (int)oci_result($productsInOrder, "quantity")
               ];
            };

            $response[] = [
                'id' => (int)oci_result($orders, "id"),
                'customerName' => oci_result($orders, "customerName"),
                'customerPhone' => oci_result($orders, "customerPhone"),
                'created' => oci_result($orders, "created"),
                'idOrderState' => (int)oci_result($orders, "idOrderState"),
                'orderStateCaption' => oci_result($orders, "orderStateCaption"),
                'expires' => oci_result($orders, "expires"),
                'products' => $products
            ];
        };
        return json_encode($response);
      }
      else{
        return "denied";
      }
      
    }

    public function insert(Request $request){
      require "db.php";

      $conn = oci_connect($dbuser, $dbpassword, $dbname, $dbencoding);         
      if ( ! $conn ) { 
          echo "Невозможно подключится к базе: " . var_dump( OCIError() ); 
          die(); 
      } 

      $order = $request->all();
      //return $order["customerName"];
      $idNewOrder = 0;
      $query = 'BEGIN :idNewOrder := CRM_ORDER_INSERT(:customerName, :customerPhone); END;';
      $insertOrder = OCIParse($conn, $query);
      oci_bind_by_name($insertOrder, ':customerName', $order["customerName"]);
      oci_bind_by_name($insertOrder, ':customerPhone', $order["customerPhone"]);
      oci_bind_by_name($insertOrder, ':idNewOrder', $idNewOrder, 40);
      OCIExecute($insertOrder, OCI_DEFAULT);
      oci_free_statement($insertOrder);

      $query = "DECLARE result NUMBER; BEGIN result := CRM_ORDERPRODUCT_INSERT (:idNewOrder, :idProduct, :quantity); END;";
      foreach($order["orderProducts"] as $product){
        $insertOrderProduct = OCIParse($conn, $query);
        oci_bind_by_name($insertOrderProduct, ':idNewOrder', $idNewOrder);
        oci_bind_by_name($insertOrderProduct, ':idProduct', $product["id"]);
        oci_bind_by_name($insertOrderProduct, ':quantity', $product["orderQuantity"]);
        OCIExecute($insertOrderProduct, OCI_DEFAULT);
        
      };
      


      $response = array( "idOrder" => $idNewOrder); 

      
      oci_free_statement($insertOrderProduct);
      oci_close($conn);

      return $response;
      

    }

    
    //
}
