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
      <div class="card-deck">

        <!--Card-->
        <template v-for="(item, index) in products">
          <div class="card m-2" style="padding-left:0px; padding-right:0px;" :key="item.id">

            <!--Card image-->
            <div class="view">
              <div :id="'carousele'+index" class="carousel slide" data-ride="carousel">
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
              <h4 class="card-title font-weight-bold mb-2">{{ item.caption }}</h4>
              <span class="badge badge-dark">{{ item.producttype_caption }}</span>
              <p class="card-text">{{ item.description }}</p>          
            </div>

            
              <div class="input-group m-3">
                <input class="form-control" type="number" value="1" min="1" :max="item.quantity" oninput="validity.valid||(value='');" id="example-number-input" v-model="item.orderQuantity">
                <div class="input-group-addon">
                  <button class="btn btn-block btn-primary" @click="addToCart(item)"><font-awesome-icon icon="cart-plus"/> В КОРЗИНУ</button>    
                </div>  
              </div>
            

            
            <!--Footer-->
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

          <div :key="'divider-sm-'+index" v-if="(index + 1) % 2 == 0" class="w-100 d-none d-sm-block d-md-none"><!-- wrap every 2 on sm--></div>          
          <div :key="'divider-md-'+index" v-if="(index + 1) % 3 == 0" class="w-100 d-none d-md-block d-lg-none"><!-- wrap every 3 on md--></div>
          <div :key="'divider-lg-'+index" v-if="(index + 1) % 4 == 0" class="w-100 d-none d-lg-block d-xl-none"><!-- wrap every 4 on lg--></div>
          <div :key="'divider-xl-'+index" v-if="(index + 1) % 5 == 0" class="w-100 d-none d-xl-block"><!-- wrap every 5 on xl--></div>
          
          
          
        </template>
        <!--/.Card-->
          </div>
        </div>
      </div>
</template>

<script>

/*

          
          
          

*/
export default {
  props: ['apiPrefix'],
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
    .get(this.apiPrefix + 'api/product/all')
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

