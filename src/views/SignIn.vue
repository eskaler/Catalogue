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
  data() {
    return {
      login: new String(),
      password: new String(),
      apiKey: null
    }
  },
  methods: {
    signIn: function(){
      let authData = {
        login: this.login,
        password: this.password
      }
      console.log("fuck: " + JSON.stringify(authData));
      this.axios
      .post(this.apiPrefix + "api/auth/signin", authData
      )
      .then(response => {
        //alert(response.data);
        this.apiKey = (response.data.apiKey == "denied" ? null : response.data.apiKey);
      });
      console.log(`signin ${this.apiKey}`);
      localStorage.apiKey = this.apiKey;
      if(this.apiKey != null)
        this.$emit('signed-in');
    }
  }
}
</script>
