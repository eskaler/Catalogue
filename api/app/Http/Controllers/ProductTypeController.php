<?php

namespace App\Http\Controllers;

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
