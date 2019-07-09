<template>
  <div class="productList">
    <div class="loading m-4" v-if="loading">
        <div class="progress-cover">
          <div class="progress-fluent-line progress-primary progress-medium">
            <span class="progress-span"></span>
            <span class="progress-span"></span>
            <span class="progress-span"></span>
            <span class="progress-span"></span>
            <span class="progress-span"></span>
          </div>
        </div>
    </div>

    <div class="error" v-if="error">
      {{ error }}
    </div>

    <div class="content m-4" v-if="products">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 d-flex align-items-stretch">

            <!--Card-->
            <template v-for="(item, index) in products">
              <div class="card m-2 col-auto mb-3" style="padding-left:0px; padding-right:0px;" :key="item.id">

              <!--Card image-->
              <div class="view">
                <div :id="'carousele'+index" 
                class="carousel slide" data-ride="carousel">
                  <ol class="carousel-indicators" v-if="item.photos.length > 1">
                    <li :data-target="'#carousele'+index" v-for="(photo, photoIndex) in item.photos" :key="photo.id"
                    :data-slide-to="photoIndex" class="active"></li>
                  </ol>
                  <div class="carousel-inner">
                    <div :class="['carousel-item', {'active' : photoIndex == 0 } ]" v-for="(photo, photoIndex) in item.photos" :key="photo.id">
                      <img class="d-block w-100 card-img-top" :src="photo.server + photo.filename" :alt="photo.server + photo.filename">
                    </div>
                  </div>
                  <a class="carousel-control-prev" :href="'#carousele'+index" role="button" data-slide="prev" v-if="item.photos.length > 1">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="carousel-control-next" :href="'#carousele'+index" role="button" data-slide="next" v-if="item.photos.length > 1">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>
                </div>
              </div>
              
              <!--Card content-->
              <div class="card-body">
                <!--Title-->
                <h4 class="card-title font-weight-bold mb-2">{{ item.caption }}</h4>
                <span class="badge badge-dark">{{ item.producttype_caption }}</span>
                <!--Text-->
                <p class="card-text">{{ item.description }}</p>          
                <div class="input-append">
                  <div class="input-group mb-3">
                  <input class="form-control" type="number" value="1" min="1" :max="item.quantity" oninput="validity.valid||(value='');" id="example-number-input" v-model="item.orderQuantity">
                  <div class="input-group-append">
                    <button class="btn btn-block btn-primary" @click="addToCart(item)"><font-awesome-icon icon="cart-plus"/> В корзину</button>    
                  </div>
                </div>
                    
                    
                </div>
                  
                  
              </div>

              <div class="card-footer bg-transparent d-flex justify-content-between">
                <span>В наличии:
                  <strong class="font-weight-bold">{{ item.quantity }}</strong>
                </span>
                <div>
                  Цена:
                  <strong class="text-primary font-weight-bold">{{ item.price}}<font-awesome-icon icon="ruble-sign"/></strong>
                </div>
              </div>       
              </div>
                        </template>
        <!--/.Card-->
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
      products: null,
      error: null
    }
  },
  methods:{
    addToCart: function(product) {
      this.$emit('added-to-cart', product);
    }
  },
  mounted() {
    this.loading = true;
    this.axios
    .get('/products/')
    .then(response => {
      this.products = response.data;
    })
    .finally(() =>(this.loading = false));
  }
}

</script>

<style>
.card-img-top {
    width: 100%;
    height: 15vw;
    object-fit: cover;
}
</style>

