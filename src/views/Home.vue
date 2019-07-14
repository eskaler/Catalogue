<template>
  <div class="home m-4">
    <h3 v-if="isAuthorized()">Добро пожаловать в систему!</h3>
  </div>
</template>

<script>
export default {
  methods: {
    isAuthorized : function(){
      return false;
    }
  } 
}
</script>
