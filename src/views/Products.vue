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

    <div class="error" v-if="error">{{ error }}</div>

    <div class="content" v-if="!loading">
      <!-- search form -->
      <div class="search-bar ml-4">
        <div class="row">
          <div class="form-group col-xs-4 col-md-4 m-2">
            <div class="d-flex flex-column">
              <label for="nameInput" class="control-lable">Наименование</label>
              <input type="text" name id="nameInput" v-model="productCaption" />
            </div>
          </div>
          <div class="form-group col-xs-4 col-md4 m-2">
            <div class="d-flex flex-column">
              <label for="productTypeList" class="control-label">Категория</label>
              <select v-model="selectedProductType" id="productTypeList" class="custom-select">
                <option value="any" selected>Любая</option>
                <option
                  v-for="(item, index) in categories"
                  :value="item.name"
                  :key="item.name + index"
                >{{ item.caption }}</option>
              </select>
            </div>
          </div>
          <div class="form-group col-xs-4 col-md4 m-2">
            <div class="d-flex flex-column">
              <label for="priceMin" class="control-label">Цена от</label>
              <input
                type="number"
                oninput="validity.valid||(value='');"
                id
                v-model.number="priceMin"
              />
            </div>
          </div>
          <div class="form-group col-xs-4 col-md4 m-2">
            <div class="d-flex flex-column">
              <label for="priceMax" class="control-label">Цена до</label>
              <input
                type="number"
                oninput="validity.valid||(value='');"
                id
                v-model.number="priceMax"
              />
            </div>
          </div>
          <div class="form-group col-xs-4 col-md4 m-3">
            <div class="d-flex flex-column">
              <p></p>
              <button type="submit" class="btn btn-outline-default" @click="searchProducts()">
                <font-awesome-icon icon="search" />ПОИСК
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="card-deck m-2">
        <!--Card-->
        <template v-for="(item, index) in products">
          <div class="card m-3" style="padding-left:0px; padding-right:0px;" :key="item.id">
            <!--Card image-->
            <div class="view">
              <div :id="'carousele'+index" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators" v-if="item.photos.length > 1">
                  <li
                    :data-target="'#carousele'+index"
                    v-for="(photo, photoIndex) in item.photos"
                    :key="photo.id"
                    :data-slide-to="photoIndex"
                    class="active"
                  ></li>
                </ol>
                <div class="carousel-inner">
                  <div
                    :class="['carousel-item', {'active' : photoIndex == 0 } ]"
                    v-for="(photo, photoIndex) in item.photos"
                    :key="photo.id"
                  >
                    <img
                      class="d-block w-100 card-img-top"
                      :src="photo.server + photo.name"
                      :alt="photo.server + photo.name"
                      data-toggle="modal"
                      data-target="#exampleModal3"
                      @click="setPhotoZoom(photo.server + photo.name, item.caption)"
                    />
                  </div>
                </div>
                <a
                  class="carousel-control-prev"
                  :href="'#carousele'+index"
                  role="button"
                  data-slide="prev"
                  v-if="item.photos.length > 1"
                >
                  <span class="carousel" aria-hidden="true">
                    <font-awesome-icon icon="angle-left" class="text-dark" />
                  </span>
                  <span class="sr-only">Previous</span>
                </a>
                <a
                  class="carousel-control-next"
                  :href="'#carousele'+index"
                  role="button"
                  data-slide="next"
                  v-if="item.photos.length > 1"
                >
                  <span class="carousel" aria-hidden="true">
                    <font-awesome-icon icon="angle-right" class="text-dark" />
                  </span>
                  <span class="sr-only">Next</span>
                </a>
              </div>
            </div>

            <!--Card content-->
            <div class="card-body">
              <h5 class="card-title font-weight-bold mb-2">{{ item.caption }}</h5>
              <span class="badge badge-dark">{{ item.category.caption }}</span>
              
              <p class="card-text">{{ item.description }}</p>

              

            </div>

            <!-- Кнопка В КОРЗИНУ -->  
            <button class="btn btn-primary" @click="addToCart(item)">
                <font-awesome-icon icon="cart-plus" /> В КОРЗИНУ
              </button>
            
            
            <!--<div class="form-row mb-2">
              <input class="m-2 ml-4" type="number" value="1" min="1" :max="item.quantity" oninput="validity.valid||(value='');" id="example-number-input" v-model="item.orderQuantity">
              
            </div>-->

            <!--Footer-->
            <div class="card-footer bg-transparent d-flex justify-content-between">
              <span>
                В наличии:
                <strong class="font-weight-bold">{{ item.quantity }}</strong>
              </span>
              <div>
                Цена:
                <strong class="text-primary font-weight-bold">
                  {{ item.price}}
                  <font-awesome-icon icon="ruble-sign" />
                </strong>
              </div>
              
            </div>
          </div>
          <div
            :key="'divider-sm-'+index"
            v-if="(index + 1) % 2 == 0"
            class="w-100 d-none d-sm-block d-md-none"
          >
            <!-- wrap every 2 on sm-->
          </div>
          <div
            :key="'divider-md-'+index"
            v-if="(index + 1) % 3 == 0"
            class="w-100 d-none d-md-block d-lg-none"
          >
            <!-- wrap every 3 on md-->
          </div>
          <div
            :key="'divider-lg-'+index"
            v-if="(index + 1) % 4 == 0"
            class="w-100 d-none d-lg-block d-xl-none"
          >
            <!-- wrap every 4 on lg-->
          </div>
          <div
            :key="'divider-xl-'+index"
            v-if="(index + 1) % 4 == 0"
            class="w-100 d-none d-xl-block"
          >
            <!-- wrap every 5 on xl-->
          </div>
        </template>

        <!-- Photo -->
        <div
          class="modal fade"
          id="exampleModal3"
          tabindex="-1"
          role="dialog"
          aria-labelledby="exampleModalLabel3"
          aria-hidden="true"
        >
          <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel3">{{ photoZoomName }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <img class="d-block w-100" :src="photoZoomSrc" />
              </div>
              <div class="modal-footer"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["apiPrefix"],
  data() {
    return {
      loading: true,
      products: [],
      categories: [],
      error: null,

      photoZoomSrc: null,
      photoZoomName: null,

      productCaption: null,
      selectedProductType: "any",
      priceMin: 0,
      priceMax: 0
    };
  },
  methods: {
    setPhotoZoom: function(src, name) {
      this.photoZoomSrc = src;
      this.photoZoomName = name;
      return;
    },
    addToCart: function(product) {
      this.$emit("added-to-cart", product);
    },
    searchProducts: function() {
      let apiQuery = `api/product/search/caption/${this.getProductCaption}/pricemin/${this.getPriceMin}/pricemax/${this.getPriceMax}/producttype/${this.selectedProductType}`;
      console.log(apiQuery);
      this.axios
        .get(this.apiPrefix + apiQuery)
        .then(response => {
          this.products = response.data;
        })
        .finally(() => (this.loading = false));
    }
  },
  computed: {
    getProductCaption: function() {
      return (this.productCaption == '' || this.productCaption == null) ? "any" : this.productCaption;
    },
    getPriceMin: function() {
      return (this.priceMin == null || this.priceMin == '' || this.priceMin < 0 ) ? 0 : this.priceMin;
    },
    getPriceMax: function() {
      if(this.priceMax == 0 || this.priceMax < this.priceMin)
        return 999999;
      else
        return (this.priceMax == null || this.priceMax == '' || this.priceMax < 0) ? 0 : this.priceMax;
    }
  },
  mounted() {
    this.loading = true;

    this.axios
      .get(this.apiPrefix + "api/categories")
      .then(response => {
        this.categories = response.data.data;
        console.log(this.categories);
      })
      .then(
        this.axios.get(this.apiPrefix + "api/products").then(response => {
          this.products = response.data.data;
          //console.log(this.products);
        })
      )
      .finally(() => (this.loading = false));
  }
};
</script>

<style>
/*.carousel-control-prev-icon, 
.carousel-control-next-icon {
  height: 100px;
  width: 100px;
  outline: black;
  background-size: 100%, 100%;
  
  background-image: none;
}

.carousel-control-next-icon:after
{
  content: '>';
  font-size: 40px;
  font-weight: bold;
  color: #E74856;
}

.carousel-control-prev-icon:after {
  content: '<';
  font-size: 40px;
  font-weight: bold;
  color: #E74856;
}*/

.card-img-top {
  width: 100%;
  height: 15vw;
  object-fit: cover;
  cursor: zoom-in;
}
</style>

