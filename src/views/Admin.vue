<template>
  <div class="signin m-4">

    <router-view
      @signed-in="selectAdminPage"
      :api-prefix="apiPrefix"
    />
    
    
  </div>
</template>

<script>

export default {
  props: ['apiPrefix'],
  name: 'signin',
  
  data(){
    return {
      apiKey: null
    }
  },
  
  methods: {
    selectAdminPage: function(){
      this.apiKey = localStorage.apiKey;
      console.log("localStorage.apiKey: " + localStorage.apiKey);
      if(this.apiKey == null){
        this.$router.push("/admin/signin");
      }
      else {
        this.$router.push("/admin/panel");
      }
    }
  }
  ,
  mounted() {
    this.selectAdminPage();
  }
    
}
</script>

