<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AuthController extends Controller
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

    public function signin(Request $request){
        require "db.php";
  
        $conn = oci_connect($dbuser, $dbpassword, $dbname, $dbencoding);         
        if ( ! $conn ) { 
            echo "Невозможно подключится к базе: " . var_dump( OCIError() ); 
            die(); 
        } 
  
        
        
        $password = hash("sha256", $request->input('password'));
        $login = $request->input('login');

        //echo "login: $login\npassword: $password\n";

        $query = "BEGIN :idUser := CRM_USER_SIGNIN(:login, :password); END;";
        $getUser = OCIParse($conn, $query);
        oci_bind_by_name($getUser, ':login', $login);
        oci_bind_by_name($getUser, ':password', $password);
        oci_bind_by_name($getUser, ':idUser', $idUser);
        
        oci_execute($getUser, OCI_DEFAULT);

        if($idUser == 0){
            oci_free_statement($getUser);
            oci_close($conn);
            return array( "apiKey" => "denied");
        }
            
        else {
            $apiKey = base64_encode(str_random(40));
            $query = "BEGIN CRM_USER_SETAPIKEY(:idUser, :apiKey); END;";
            $getUser = OCIParse($conn, $query);
            oci_bind_by_name($getUser, ':idUser', $idUser);
            oci_bind_by_name($getUser, ':apiKey', $apiKey);
            oci_execute($getUser, OCI_DEFAULT);
            oci_free_statement($getUser);
            oci_close($conn);
            return array( "apiKey" => $apiKey);
        }
  
      }

    //
}
