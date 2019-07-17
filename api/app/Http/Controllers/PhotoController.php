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

class PhotoController extends Controller
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

        $idProduct = (int)$request->input('idProduct');
        
        $data = $request->all();
        $png_url = str_random(10).'.'.'png';
        $path = base_path('public/') . "photos/" . $png_url;
        $img = $data['image'];
        $img = substr($img, strpos($img, ",")+1);
        $data = base64_decode($img);
        $success = file_put_contents($path, $data);

        /*$image = $request->input('image');  // your base64 encoded
        $image = str_replace('data:image/png;base64,', '', $image);
        $image = str_replace(' ', '+', $image);
        $imageName = str_random(10).'.'.'png';
        file_put_contents('photo/'. $imageName, base64_decode($image));

        
        echo "<img src='http://localhost:8000/photo/$imageName' />";*/

        $photoNew = oci_parse($conn, "BEGIN :idNewPhoto := CRM_PHOTO_INSERT(:idProduct, :imageName); END;");
        
        oci_bind_by_name($photoNew, ':idProduct', $idProduct);
        oci_bind_by_name($photoNew, ':imageName', $png_url);
        oci_bind_by_name($photoNew, ':idNewPhoto', $idNewPhoto, 40);
        
        oci_execute($photoNew, OCI_DEFAULT); 

        oci_free_statement($photoNew);
        oci_close($conn);
        return array("idNewPhoto" => $idNewPhoto);
      }
      else{
        return "denied";
      }
    }
}

    
