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
        <!--#region Tabs -->
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
        <!--#endregion -->
      </div>
      <div class="tab-pane fade" id="product" role="tabpanel" aria-labelledby="product-tab">
        <div id="product">
          <p><button class="btn btn-primary" @click="newProduct" data-toggle="modal" data-target="#productModal"><font-awesome-icon icon="plus"/> Новый</button></p>
          <v-client-table :data="productData"  :columns="productColumns" :options="productOptions">
            <span slot="edit" slot-scope="{row}"> 
              <a href="#" @click="editProduct(row)" data-toggle="modal" data-target="#productModal"><font-awesome-icon icon="edit"/></a>
            </span>
          </v-client-table>
        </div>
          

        </div>

              <div class="tab-pane fade" id="producttype" role="tabpanel" aria-labelledby="producttype-tab">
        <div id="productType">
          
              <p><button class="btn btn-primary" @click="newProductType" data-toggle="modal" data-target="#productTypeModal"><font-awesome-icon icon="plus"/> Новый</button></p>
              <v-client-table :data="productTypeData"  :columns="productTypeColumns" :options="productTypeOptions">
                <span slot="edit" slot-scope="{row}"> 
                  <a href="#" @click="editProductType(row)" data-toggle="modal" data-target="#productTypeModal"><font-awesome-icon icon="edit"/></a>
                </span>
              </v-client-table>
          

          

        </div>
      </div>
      </div>



        <!-- MODALS -->

        <!-- PRODUCT MODAL -->
        <div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModal" aria-hidden="true">
          <div :class="['modal-dialog', { 'modal-md' : photoZoomToggle}, {'modal-lg' : !photoZoomToggle}]" role="document">

                <div class="modal-content" v-if="photoZoomToggle">
                <div class="modal-header">
                  <a href="#" @click="photoZoomToggle = !photoZoomToggle" ><font-awesome-icon icon="arrow-left"/></a>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <img class="d-block w-100" :src="photoZoomSrc"/>
                </div>
                <div class="modal-footer">    
                </div>
              </div>

            <div class="modal-content" v-else>

              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel3">{{ viewProduct.caption }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>

              <div class="modal-body">
                <div class="row">
                  <div class="col-sm">
                    <p><label for="inputProductName">Артикул </label><input id="inputProductName" type="text" class="form-control" v-model="viewProduct.name"></p>
                  </div>
                  <div class="col-sm">
                    <p><label for="inputProductCaption">Наименование </label><input id="inputProductCaption" type="text" class="form-control" v-model="viewProduct.caption"></p>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm">
<p><label for="inputProductDescription">Описание </label><input id="inputProductDescription" type="text" class="form-control" v-model="viewProduct.description"></p>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
<p><label for="inputProductQuantity">Количество </label><input id="inputProductQuantity" type="number" min="0" oninput="validity.valid||(value='');" class="form-control" v-model.number="viewProduct.quantity"></p>
                  </div>
                  <div class="col-3"><p><label for="inputProductPrice">Цена </label><input id="inputProductPrice" type="number" min="0" oninput="validity.valid||(value='');" class="form-control" v-model.number="viewProduct.price"></p></div>
                  <div class="col-6">
                    <p><label for="inputProductIdProductType">Категория товара </label>
              <select class="form-control" v-model="viewProduct.producttype_id" id="inputProductIdProductType">
                  <option v-for="(item, index) in productTypeData" :value="item.id" :key="item.name + index">
                   {{ item.caption }}
                  </option>
               </select></p>
                  </div>
                </div>
                <div class="row">
                  <div class="col-6">
                    <div class="view">
                      <div id="carousele" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators" v-if="renderCarousel && viewProduct.photos.length > 1">
                          <li data-target="carousele" v-for="(photo, photoIndex) in viewProduct.photos" :key="photo.id"
                          :data-slide-to="photoIndex" class="active"></li>
                        </ol>
                        <div class="carousel-inner">
                          <div :class="['carousel-item', {'active' : photoIndex == 0 } ]" v-for="(photo, photoIndex) in viewProduct.photos" :key="photo.id">
                            <img class="card-img-top" :src="photo.server + photo.filename" :alt="photo.server + photo.filename"
                            data-toggle="modal" data-target="#exampleModal3" @click="setPhotoZoom(photo.server + photo.filename, viewProduct.caption)">
                          </div>
                        </div>
                        <a class="carousel-control-prev" href="#carousele" role="button" data-slide="prev" v-if="viewProduct.photos.length > 1">
                          <span class="carousel" aria-hidden="true"><font-awesome-icon icon="angle-left" class="text-dark"/></span>
                          <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carousele" role="button" data-slide="next" v-if="viewProduct.photos.length > 1">
                          <span class="carousel" aria-hidden="true"><font-awesome-icon icon="angle-right" class="text-dark"/></span>
                          <span class="sr-only">Next</span>
                        </a>
                      </div>
                    </div>
                  </div>
                  <div class="col-6">
                    <div v-if="!image">
                      <p>Загрузить изображение</p>
                      <input type="file" @change="onFileChange">
                    </div>
                    <div v-else>
                      <img :src="image" class="card-img-top" />
                      <button @click="removeImage" class="btn btn-default">Удалить</button>
                      <button @click="uploadImage" class="btn btn-default">Загрузить</button>
                    </div>
                  </div>
                </div>
                

              </div>
              <div class="modal-footer">
                <p>
                 <span v-if="viewProduct.id==0"><button class="btn btn-primary" @click="saveNewProduct"><font-awesome-icon icon="plus"/> Создать</button></span>
                 <span v-else><button class="btn btn-primary" @click="saveProduct"><font-awesome-icon icon="save"/> Сохранить</button></span>
                 </p>
              </div>
            </div>
          </div>
        </div>

        <!-- PRODUCTTYPE MODAL -->
        <div class="modal fade" id="productTypeModal" tabindex="-1" role="dialog" aria-labelledby="productTypeModal" aria-hidden="true">
          <div class="modal-dialog modal-md " role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel3"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                 <p><label for="inputProductTypeName">Системное название </label><input type="text" class="form-control" v-model="viewProductType.name" id="inputProductTypeName"></p>
              <p><label for="inputProductTypeCaption">Наименование </label><input type="text" class="form-control" v-model="viewProductType.caption" id="inputProductTypeCaption"></p>
              
               
              </div>
              <div class="modal-footer">
               <p>
                <span v-if="viewProductType.id==0"><button class="btn btn-primary" @click="saveNewProductType"><font-awesome-icon icon="plus"/> Создать</button></span>
                <span v-else><button class="btn btn-primary" @click="saveProductType"><font-awesome-icon icon="save"/> Сохранить</button></span>
              </p>
              </div>
            </div>
          </div>
        </div>

        <!-- PHOTO ZOOM MODAL -->
        <div class="modal fade" id="photoZoomModal" tabindex="-2" role="dialog" aria-labelledby="photoZoomModal" aria-hidden="true">
          <div class="modal-dialog modal-md " role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel3">{{ photoZoomName }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <img class="d-block w-100" :src="photoZoomSrc"/>
              </div>
              <div class="modal-footer">
                
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
      photoZoomSrc: null,
      photoZoomName: null,
      photoZoomToggle: false,
      photoFile: null,
      image: '',

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

        }
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
        }
      },
      viewProduct: {
        id: 0,
        name: '',
        caption: '',
        description: '',
        quantity: 0,
        price: 0,
        producttype_id: 0,
        photos: []
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
      renderCarousel: true
    }
  },
  methods: {
    forceCarouselRerender() {
      console.log("called");
        // Remove my-component from the DOM
        this.renderCarousel = false;
        
        this.$nextTick(() => {
          // Add the component back in
          this.renderCarousel = true;
        });
    },
    setPhotoZoom: function(src, name){
      this.photoZoomSrc = src;
      this.photoZoomName = name;
      this.photoZoomToggle = true;
      return;
    },
    onFileChange(e) {
      var files = e.target.files || e.dataTransfer.files;
      if (!files.length)
        return;
      this.createImage(files[0]);
    },
    createImage(file) {
      var image = new Image();
      var reader = new FileReader();
      var vm = this;

      reader.onload = (e) => {
        vm.image = e.target.result;
      };
      reader.readAsDataURL(file);
    },
    removeImage: function (e) {
      this.image = '';
    },
    uploadImage: function() {
      console.log(this.image);
      let newPhoto = {
        apiKey: localStorage.apiKey,
        idProduct: this.viewProduct.id,
        image: this.image
      };
      console.log(newPhoto);
      this.axios
      .post(this.apiPrefix + "api/photo/new",
      newPhoto)
      .then(
        this.getProductsData()
      )
      .then(
        this.getViewProduct()
      )
      .finally(
        this.image=''
      );
      
    },
    getViewProduct: function(){
      this.productData.forEach(product => {
        if(product.id == this.viewProduct.id){
          this.viewProduct = product;
          this.forceCarouselRerender();
          return;
        }
      });
    },
    getProductData: function(idProduct){
      this.axios
      .get(this.apiPrefix + `api/product/${idProduct}`)
      .then(
        this.viewProduct = response.data
      );
    },

    prolongOrder: function(order){
      console.log("prolongOrder called");
      this.axios
      .post(this.apiPrefix + "api/order/prolong",
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
      .post(this.apiPrefix + "api/order/cancel",
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
      .post(this.apiPrefix + "api/order/pay",
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
      this.photoZoomToggle = false;
    },
    saveProduct: function(){
      console.log("newProduct called");
      let newProduct = this.viewProduct;
      newProduct.apiKey = localStorage.apiKey;
      console.log(newProduct);
      this.axios
      .post(this.apiPrefix + "api/product/update", newProduct)
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
      .post(this.apiPrefix + "api/product/new", newProduct)
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
        photos: []
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
      .post(this.apiPrefix + "api/producttype/update", newProductType)
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
      .post(this.apiPrefix + "api/producttype/new", newProductType)
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
      .post(this.apiPrefix + "api/order/all",
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
      .get(this.apiPrefix + "api/product/all")
      .then(response => {
        this.productData = response.data;
      });
      return;
    },
    
    getProductTypesData: function(){
      this.axios
      .get(this.apiPrefix + "api/producttype/all")
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
.card-img-top {
    width: 100%;
    height: 15vw;
    object-fit: cover;
    cursor: zoom-in;
}

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
