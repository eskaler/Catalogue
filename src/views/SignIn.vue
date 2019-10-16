<template>

<div class="container h-100">
  <div class="row h-100 justify-content-center align-items-center">
    <form class="col-4">
      <p><h3>Вход в систему</h3>
      <div class="form-group">
        <input type="text" class="form-control" id="loginInput" autocomplete="username"
        placeholder="Логин" v-model="login">
      </div>
      <div class="form-group">
        <input type="password" class="form-control" id="passwordInput" autocomplete="current-password"
        placeholder="Пароль" v-model="password">
      </div>
      <div class="form-group">
        <button class="btn btn-block btn-primary" @click="signIn()">Вход</button>
      </div>
    </form>   
  </div>
</div>


</template>

<script>
export default {
  props: [ 'apiPrefix'],
  name: 'signin',
  data: function() {
    return {
      login: new String(),
      password: new String(),
    }
  },
  methods: {
    signIn: function(){
      localStorage.apiKey = null;
      let authData = {
        login: this.login,
        password: this.password
      };
      this.axios
      .post(this.apiPrefix + "api/auth/signin", authData
      )
      .then(response => {
        //alert(response.data.apiKey);
        localStorage.apiKey = (response.data.apiKey == "denied" ? null : response.data.apiKey);
      });
      
      console.log(`signin ${localStorage.apiKey}`);
      
      if(localStorage.apiKey)
        this.signedIn();
      
      return;
    },
    signedIn: function(){
      this.$emit('signed-in');
    }
  }
}
</script>
