<template>
  <div class="panel">
    
    <ul class="nav nav-tabs fluent-tabs" id="myTab" role="tablist">
      <li class="nav-item">
        <a class="nav-link active" id="order-tab" data-toggle="tab" href="#order" role="tab" aria-controls="order" aria-selected="true">Заказы</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" id="product-tab" data-toggle="tab" href="#product" role="tab" aria-controls="product" aria-selected="false">Товары</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" id="producttype-tab" data-toggle="tab" href="#producttype" role="tab" aria-controls="producttype" aria-selected="false">Категории товаров</a>
      </li>
    </ul>
    <div class="tab-content" id="myTabContent">
      <div class="tab-pane fade show active" id="order" role="tabpanel" aria-labelledby="order-tab">
        <div id="order">
          <v-client-table :data="orderData"  :columns="orderColumns" :options="orderOptions">
            <div slot="child_row" slot-scope="props">
              <table class="table">
                <thead >
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Изображение</th>
                    <th scope="col">Артикул</th>
                    <th scope="col">Наименование</th>
                    <th scope="col">Цена</th>
                    <th scope="col">Кол-во</th>
                    <th scope="col">Стоимость</th>
                    
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in props.row.products" :key="index">
                    <th scope="row">{{index + 1}}</th>
                    <td><img class="productPhoto" :src="item.photo" /></td>
                    <td>{{ item.name }}</td>
                    <td>{{ item.caption }}</td>
                    <td>{{ item.price }}₽</td>
                    <td>{{ item.orderQuantity }}</td>
                    <td>{{ item.price * item.orderQuantity}}₽</td>
                  </tr>
                </tbody>
                </table>
              
            </div>
            <span slot="orderSum" slot-scope="{row}"> 
              {{calculateSum(row)}}₽
            </span>
            <span slot="prolong" slot-scope="{row}"> 
              <a href="#" @click="prolongOrder(row)" v-if="row.idOrderState == 1"><font-awesome-icon icon="clock"/></a>
            </span>
            <span slot="paid" slot-scope="{row}"> 
              <a href="#" @click="paidOrder(row)" v-if="row.idOrderState == 1"><font-awesome-icon icon="money-bill"/></a>
            </span>
            <span slot="cancel" slot-scope="{row}"> 
              <a href="#" @click="cancelOrder(row)" v-if="row.idOrderState == 1"><font-awesome-icon icon="window-close"/></a>
            </span>
          </v-client-table>
        </div>
      </div>
      <div class="tab-pane fade" id="product" role="tabpanel" aria-labelledby="product-tab">
        <div id="product">
          <div class="row">
            <div class="col-8">
              <p><button class="btn btn-primary" @click="newProduct"><font-awesome-icon icon="plus"/> Новый</button></p>
              <v-client-table :data="productData"  :columns="productColumns" :options="productOptions">
                <span slot="edit" slot-scope="{row}"> 
                  <a href="#" @click="editProduct(row)"><font-awesome-icon icon="edit"/></a>
                </span>
              </v-client-table>
            </div>
            <div class="col-4">
              <p><label for="">Артикул: </label><input type="text" v-model="viewProduct.name"></p>
              <p><label for="">Наименование: </label><input type="text" v-model="viewProduct.caption"></p>
              <p><label for="">Описание: </label><input type="text" v-model="viewProduct.description"></p>
              <p><label for="">Количество: </label><input type="number" min="0" oninput="validity.valid||(value='');" v-model.number="viewProduct.quantity"></p>
              <p><label for="">Цена: </label><input type="number" min="0" oninput="validity.valid||(value='');"  v-model.number="viewProduct.price"></p>
              <p><label for="">Категория товара: </label>
              <select v-model="viewProduct.producttype_id" id="productTypeList" class="custom-select">
                  <option v-for="(item, index) in productTypeData" :value="item.id" :key="item.name + index">
                   {{ item.caption }}
                  </option>
               </select></p>
               <p>
                 <span v-if="viewProduct.id==0"><button class="btn btn-primary" @click="saveNewProduct"><font-awesome-icon icon="plus"/> Создать</button></span>
                 <span v-else><button class="btn btn-primary" @click="saveProduct"><font-awesome-icon icon="save"/> Сохранить</button></span>
                 </p>
            </div>
          </div>
          

        </div>
      </div>
      <div class="tab-pane fade" id="producttype" role="tabpanel" aria-labelledby="producttype-tab">
        <div id="productType">
          <div class="row">
            <div class="col-8">
              <p><button class="btn btn-primary" @click="newProductType"><font-awesome-icon icon="plus"/> Новый</button></p>
              <v-client-table :data="productTypeData"  :columns="productTypeColumns" :options="productTypeOptions">
                <span slot="edit" slot-scope="{row}"> 
                  <a href="#" @click="editProductType(row)"><font-awesome-icon icon="edit"/></a>
                </span>
              </v-client-table>
            </div>
            <div class="col-4">
              <p><label for="">Системное название: </label><input type="text" v-model="viewProductType.name"></p>
              <p><label for="">Наименование: </label><input type="text" v-model="viewProductType.caption"></p>
              <p>
                <span v-if="viewProductType.id==0"><button class="btn btn-primary" @click="saveNewProductType"><font-awesome-icon icon="plus"/> Создать</button></span>
                <span v-else><button class="btn btn-primary" @click="saveProductType"><font-awesome-icon icon="save"/> Сохранить</button></span>
              </p>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: ['apiPrefix'],
  data() {
    return {

      orderData: [],
      orderColumns: 
        ['id', 'customerName', 'customerPhone', 
        'created', 'expires','orderStateCaption', 'orderSum' ,
        'prolong', 'paid', 'cancel'],
      orderOptions:{
        headings: {
          id: '№',
          customerName: 'ФИО заказчика',
          customerPhone: 'Телефон',
          created: 'Дата создания',
          expires: 'Истекает',
          orderStateCaption: 'Статус',
          orderSum: 'Сумма',
          prolong: 'Продлить',
          paid: 'Принять оплату',
          cancel: 'Отменить'

        },
      } ,
      
      productData: [],
      productColumns: ['id', 'name', 'caption', 'price', 'quantity', 'edit'],
      productOptions: {
        headings: {
          name: 'Артикул',
          caption: 'Наименование',
          price: 'Цена',
          quantity: 'Количество',
          edit: 'Изменить'
        },    
      },
      viewProduct: {
        id: 0,
        name: '',
        caption: '',
        description: '',
        quantity: 0,
        price: 0,
        producttype_id: 0
      },

      productTypeData: [],
      productTypeColumns: ['id', 'name', 'caption', 'edit'],
      productTypeOptions: {
        headings: {
          name: 'Системное название',
          caption: 'Наименование',
          edit: 'Изменить'
        },
      },
      viewProductType: {
        id: 0,
        name: '',
        caption: '',
      },

    }
  },
  methods: {
    prolongOrder: function(order){
      console.log("prolongOrder called");
      this.axios
      .post("http://localhost:8000/api/order/prolong",
      {
        apiKey: localStorage.apiKey,
        idOrder: order.id
      })
      .then(response =>{
        console.log(response.data);
      })
      .finally(
        this.getOrdersData()
      );
    },
    cancelOrder: function(order){
      console.log("cancelOrder called");
      this.axios
      .post("http://localhost:8000/api/order/cancel",
      {
        apiKey: localStorage.apiKey,
        idOrder: order.id
      })
      .then(response =>{
        console.log(response.data);
      })
      .finally(
        this.getOrdersData()
      );
    },
    paidOrder: function(order){
      console.log("paidOrder called");
      this.axios
      .post("http://localhost:8000/api/order/pay",
      {
        apiKey: localStorage.apiKey,
        idOrder: order.id
      })
      .then(response =>{
        console.log(response.data);
      })
      .finally(
        this.getOrdersData()
      );
    },

    editProduct: function(product){
      this.viewProduct = product;
    },
    saveProduct: function(){
      console.log("newProduct called");
      let newProduct = this.viewProduct;
      newProduct.apiKey = localStorage.apiKey;
      console.log(newProduct);
      this.axios
      .post("http://localhost:8000/api/product/update", newProduct)
      .then(response =>{
        console.log(response.data);
      })
      .finally(
        this.getProductsData()
      );
    },
    saveNewProduct: function(){
      console.log("saveNewProduct called");
      let newProduct = this.viewProduct;
      newProduct.apiKey = localStorage.apiKey;
      console.log(newProduct);
      this.axios
      .post("http://localhost:8000/api/product/new", newProduct)
      .then(response =>{
        console.log(response.data);
      })
      .finally(
        this.getProductsData()
      );
    },
    newProduct: function(product){
      this.viewProduct = {
        id: 0,
        name: '',
        caption: '',
        description: '',
        quantity: 0,
        price: 0,
        productTypeCaption: '',
        productTypeId: 0,
      };
    },

    editProductType: function(productType){
      this.viewProductType = productType;
    },
    saveProductType: function(){
      console.log("newProductType called");
      let newProductType = this.viewProductType;
      newProductType.apiKey = localStorage.apiKey;
      console.log(newProductType);
      this.axios
      .post("http://localhost:8000/api/producttype/update", newProductType)
      .then(response =>{
        console.log(response.data);
      })
      .finally(
        this.getProductsTypeData()
      );
    },
    saveNewProductType: function(){
      console.log("saveNewProductType called");
      let newProductType = this.viewProductType;
      newProductType.apiKey = localStorage.apiKey;
      console.log(newProductType);
      this.axios
      .post("http://localhost:8000/api/producttype/new", newProductType)
      .then(response =>{
        console.log(response.data);
      })
      .finally(
        this.getProductsTypeData()
      );
    },
    newProductType: function(product){
      this.viewProductType = {
        id: 0,
        name: '',
        caption: '',
      };
    },

    calculateSum: function(order){
      let sum = 0;
      order.products.forEach(item => {
        sum += item.orderQuantity * item.price;
      });
      return sum;
    },

    getOrdersData: function(){
      this.axios
      .post("http://localhost:8000/api/order/all",
      {
        apiKey: localStorage.apiKey
      })
      .then(response => {
        this.orderData = response.data;
      });
      return;
    },
    getProductsData: function(){
      this.axios
      .get("http://localhost:8000/api/product/all")
      .then(response => {
        this.productData = response.data;
      });
      return;
    },
    getProductTypesData: function(){
      this.axios
      .get("http://localhost:8000/api/producttype/all")
      .then(response => {
        this.productTypeData = response.data;
      });
      return;
    }
  },
  mounted() {
    this.getOrdersData();
    this.getProductsData();
    this.getProductTypesData();  
  }
}
</script>

<style>
.VueTables__child-row-toggler {
  width: 16px;
  height: 16px;
  line-height: 16px;
  display: block;
  margin: auto;
  text-align: center;
}

.VueTables__child-row-toggler--closed::before {
  content: "+";
}

.VueTables__child-row-toggler--open::before {
  content: "-";
}

.productPhoto{
  max-height: 50px;
}

</style>
