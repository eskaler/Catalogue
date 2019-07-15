<template>
  <div class="panel m-4">
    
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
          <v-client-table :data="orderData"  :columns="orderColumns" :options="orderOptions"></v-client-table>
        </div>
      </div>
      <div class="tab-pane fade" id="product" role="tabpanel" aria-labelledby="product-tab">
        <div id="product">
          <v-client-table :data="productData"  :columns="productColumns" :options="productOptions"></v-client-table>
        </div>
      </div>
      <div class="tab-pane fade" id="producttype" role="tabpanel" aria-labelledby="producttype-tab">
        <div id="productType">
          <v-client-table :data="productTypeData" :columns="productTypeColumns" :options="productTypeOptions"></v-client-table>
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
      orderColumns: ['id', 'customerName', 'customerPhone', 'created', 'expires','orderStateCaption'],
      orderOptions:{
        headings: {
          id: '№',
          customerName: 'ФИО заказчика',
          customerPhone: 'Телефон',
          created: 'Дата создания',
          expires: 'Истекает',
          orderStateCaption: 'Статус'
        },
      } ,
      
      productData: [],
      productColumns: ['id', 'name', 'caption', 'price', 'quantity'],
      productOptions: {
        headings: {
          name: 'Артикул',
          caption: 'Наименование',
          price: 'Цена',
          quantity: 'Количество'
        },
        
      },

      productTypeData: [],
      productTypeColumns: ['id', 'name', 'caption'],
      productTypeOptions: {
      headings: {
          name: 'Системное название',
          caption: 'Наименование',
        },
      },

    }
  },
  methods: {
    
  },
  mounted() {
    this.axios
    .post("http://localhost:8000/api/order/all",
    {
      apiKey: localStorage.apiKey
    })
    .then(response => {
      this.orderData = response.data;
    });

    this.axios
    .get("http://localhost:8000/api/product/all")
    .then(response => {
      this.productData = response.data;
    });
    
    this.axios
    .get("http://localhost:8000/api/producttype/all")
    .then(response => {
      this.productTypeData = response.data;
    })
    

    console.log(this.productData);    
  }
}
</script>
