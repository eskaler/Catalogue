<?php

namespace App\Http\Controllers;

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


class ProductTypeController extends Controller
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

    public function new(Request $request){
        require "db.php";
        $conn = oci_connect($dbuser, $dbpassword, $dbname, $dbencoding);         
        if ( ! $conn ) { 
            echo "Невозможно подключится к базе: " . var_dump( OCIError() ); 
            die(); 
        } 
  
        $apiKey = $request->input('apiKey');
        
        if(apiKeyIsValid($apiKey) != 0){
            $product = $request->all();
            //return $order["customerName"];
            $idNewProductType = 0;
            $query = 'BEGIN :idNewProductType := CRM_PRODUCTTYPE_INSERT(
                :name,
                :caption
            ); END;';
            $insertProductType = OCIParse($conn, $query);
            oci_bind_by_name($insertProductType, ':name', $product["name"]);
            oci_bind_by_name($insertProductType, ':caption', $product["caption"]);
            oci_bind_by_name($insertProductType, ':idNewProductType', $idNewProductType, 40);
            OCIExecute($insertProductType, OCI_DEFAULT);
            oci_free_statement($insertProductType);
            oci_close($conn);
    
            $response = array( "idNewProductType" => $idNewProductType); 
            return $response;
        };
        
        return "denied";
  
      }

      public function update(Request $request){
        require "db.php";
        $conn = oci_connect($dbuser, $dbpassword, $dbname, $dbencoding);         
        if ( ! $conn ) { 
            echo "Невозможно подключится к базе: " . var_dump( OCIError() ); 
            die(); 
        } 
  
        $apiKey = $request->input('apiKey');
        if(apiKeyIsValid($apiKey) != 0){
            $product = $request->all();
            $query = 'BEGIN CRM_PRODUCTTYPE_UPDATE(
                :idProductType,
                :name,
                :caption
            ); END;';
            $insertProductType = OCIParse($conn, $query);
            oci_bind_by_name($insertProductType, ':idProductType', $product["id"]);
            oci_bind_by_name($insertProductType, ':name', $product["name"]);
            oci_bind_by_name($insertProductType, ':caption', $product["caption"]);
            
            OCIExecute($insertProductType, OCI_DEFAULT);
            oci_free_statement($insertProductType);
            oci_close($conn);
    
            return "success";
        };
        
        return "denied";
  
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
        $producttypes = OCIParse($conn, "select * from V_PRODUCTTYPES"); 
        OCIExecute($producttypes, OCI_DEFAULT); 

        $response = [];
        while(OCIFetch($producttypes)){
            $response[] = [
                'id' => (int)ociresult($producttypes, "id"),
                'name' => ociresult($producttypes, "name"),
                'caption' => ociresult($producttypes, "caption"),
            ];
        };
        return json_encode($response);
    }

    //
}
