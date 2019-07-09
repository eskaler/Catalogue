<template>
  <div class="cart m-4">
    <h3>Ваша корзина
      <span v-if="cartProducts.length == 0"> пуста. Добавьте товары из каталога.</span>
      <span v-else>:</span>
      </h3> 
    <table class="table" v-if="cartProducts.length > 0">
      <thead >
        <tr>
          <th scope="col">#</th>
          <th scope="col">Изображение</th>
          <th scope="col">Артикул</th>
          <th scope="col">Наименование</th>
          <th scope="col">Цена</th>
          <th scope="col">Кол-во</th>
          <th scope="col">Стоимость</th>
          <th scope="col">Удалить</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in cartProducts" :key="index">
          <th scope="row">{{index + 1}}</th>
          <td><img class="productPhoto" :src="item.photos[0].server + item.photos[0].filename" /></td>
          <td>{{ item.name }}</td>
          <td>{{ item.caption }}</td>
          <td>{{ item.price }}₽</td>
          <td>{{ item.orderQuantity }}</td>
          <td>{{ item.price * item.orderQuantity}}₽</td>
          <td><a href="#" @click="deleteFromCart(index)"><font-awesome-icon icon="trash-alt"/></a></td>
        </tr>
      </tbody>
      <thead >
        <tr>
          <th scope="col">#</th>
          <th scope="col"></th>
          <th scope="col"></th>
          <th scope="col"></th>
          <th scope="col">Итого:</th>
          <th scope="col">{{cartCount}}</th>
          <th scope="col">{{cartSum}}₽</th>
          <th scope="col"><a href="#" @click="emptyCart()"><font-awesome-icon icon="trash-alt" class="text-primary"/></a>    </th>
        </tr>
      </thead>
      </table>

  <div class="container" v-if="cartProducts.length > 0">
    <div class="row">
      <div class="col-md-6 mb-4">
        <input class="form-control form-control-sm mr-3" type="text" placeholder="Ф.И.О." aria-label="Search">
      </div>
      <div class="col-md-6 mb-4">
        <input placeholder="Номер телефона" type="email" id="exampleForm6" class="form-control">
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 text-center mb-4">
        <button class="btn btn-primary">Оформить заказ</button>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
export default {
  props: ['cartProducts'],
  methods: {
    deleteFromCart: function(index){
      this.$emit('deleted-from-cart', index);
    },
    emptyCart: function(){
      this.$emit('cart-empty');
    }
  },
  computed: {
    cartSum: function(){
      let sum = 0;
      this.cartProducts.forEach(item => {
        sum += item.orderQuantity * item.price;
      });
      return sum;
    },
    cartCount: function(){
      let count = 0;
      this.cartProducts.forEach(item => {
        count += item.orderQuantity * 1;
      });
      return count;
    }
  }
}

</script>

<style>
.productPhoto{
  max-height: 50px;
}
</style>

