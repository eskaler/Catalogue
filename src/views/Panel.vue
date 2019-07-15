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
        <h2>First title</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt aliquid eos eum at repudiandae eius reiciendis
          nobis provident ab incidunt dolorem quae assumenda quasi modi quisquam iusto, amet fugit dolores?</p>
      </div>
      <div class="tab-pane fade" id="product" role="tabpanel" aria-labelledby="product-tab">
        <h2>Second title</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt aliquid eos eum at repudiandae eius reiciendis
          nobis provident ab incidunt dolorem quae assumenda quasi modi quisquam iusto, amet fugit dolores?</p>
      </div>
      <div class="tab-pane fade" id="producttype" role="tabpanel" aria-labelledby="producttype-tab">
        <h2>Third title</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt aliquid eos eum at repudiandae eius reiciendis
          nobis provident ab incidunt dolorem quae assumenda quasi modi quisquam iusto, amet fugit dolores?</p>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  
}
</script>
