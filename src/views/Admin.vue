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
  
  methods: {
    selectAdminPage: function(){
      
      console.log("localStorage.apiKey: " + localStorage.apiKey);
      if(!localStorage.apiKey){
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

