<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

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

    public function insert(Request $request){
      require "db.php";
      //временно
      /*header('Access-Control-Allow-Origin: *', false);
      header('Access-Control-Allow-Methods: POST');
      header('Access-Control-Allow-Headers: Content-Type, Authorization');*/

      $conn = OCILogon($dbuser, $dbpassword, $dbname, $dbencoding);         
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
