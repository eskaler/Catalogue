<?php


/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/
$router->group(['prefix' => 'api/product'], function () use ($router) {
    
    $router->get('all', 'ProductController@all');
    $router->get('search/caption/{caption}/pricemin/{pricemin}/pricemax/{pricemax}/producttype/{producttype}',
    'ProductController@search');
    $router->get('searchname/caption/{caption}',
    'ProductController@searchname');

});

$router->group(['prefix' => 'api/producttype'], function () use ($router) {
    
    $router->get('all', 'ProductTypeController@all');
    

});

$router->group(['prefix' => 'api/order'], function () use ($router){
    
    $router->post('new', 'OrderController@insert');

});

$router->group(['prefix' => 'api/auth'], function () use ($router){
    
    $router->post('signin', 'AuthController@signin');

});

$router->get('/', function () use ($router) {
    return $router->app->version();
});
