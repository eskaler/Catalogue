<template>
  <div id="app">
    <div class="wrapper">
    <!-- Sidebar -->
      <div :class="{active: isCollapsed}" class="sidebar">
          <div class="sidebar-header">
              <div class="row">
                  <button type="button" class="btn btn-secondary" @click="sidebarToggle">
                      <span v-show="isCollapsed"><font-awesome-icon icon="bars"/></span>
                      <span v-show="!isCollapsed"><font-awesome-icon icon="arrow-left"/></span>
                  </button>
              </div>
          </div>
          <ul class="list-unstyled components">
              <li><router-link to="/"><font-awesome-icon icon="home"/><br v-show="isCollapsed"> Главная</router-link></li>
              <li><router-link to="/products"><font-awesome-icon icon="list"/><br v-show="isCollapsed"> Каталог</router-link></li>
              <li><router-link to="/cart"><font-awesome-icon icon="shopping-cart"/><br v-show="isCollapsed"> Корзина</router-link></li>
              <li><router-link to="/contacts"><font-awesome-icon icon="phone"/><br v-show="isCollapsed"> Контакты</router-link></li>
              <li><router-link to="/signin"><font-awesome-icon icon="user"/><br v-show="isCollapsed"> Войти</router-link></li>
          </ul>
      </div>

      <div id="content">
          <router-view/>
      </div>
    </div>  
  </div>
</template>

<script>
export default{
  name: 'app',
  data(){
    return {
      isCollapsed: true
    }
  },
  methods: {
    sidebarToggle: function() {
        this.isCollapsed = !this.isCollapsed;
        console.log("Sidebar toggled " + this.isCollapsed)
    }
  }
}
</script>

<style>
:root{
    --colors-main: #0078D7;
    --colors-sidebar-background: #ececec;
    --colors-sidebar-text: #5a5a5a;
}

.wrapper {
    display: flex;
    align-items: stretch;
}
.sidebar {
    min-width: 250px;
    max-width: 250px;
    min-height: 100vh;

    background: var(--colors-sidebar-background);
    color: var(--colors-sidebar-text);
    transition: all 0.3s;
}


/* Shrinking the sidebar from 250px to 80px and center aligining its content*/
.sidebar.active {
    min-width: 80px;
    max-width: 80px;
    text-align: center;
}

/* Toggling the sidebar header content, hide the big heading [h3] and showing the small heading [strong] and vice versa*/
.sidebar .sidebar-header strong {
    display: none;
}
.sidebar.active .sidebar-header h3 {
    display: none;
}
.sidebar.active .sidebar-header strong {
    display: block;
}
.sidebar ul li a {
    text-align: left;
}
.sidebar.active ul li a {
    padding: 20px 10px;
    text-align: center;
    font-size: 0.85em;
}
.sidebar.active ul li a i {
    margin-right: 0;
    display: block;
    font-size: 1.8em;
    margin-bottom: 5px;
}
/* Same dropdown links padding*/
.sidebar.active ul ul a {
    padding: 10px !important;
}
/* Changing the arrow position to bottom center position,
translateX(50%) works with right: 50%
to accurately center the arrow */
.sidebar.active .dropdown-toggle::after {
    top: auto;
    bottom: 10px;
    right: 50%;
    -webkit-transform: translateX(50%);
    -ms-transform: translateX(50%);
    transform: translateX(50%);
}


/*
ADDITIONAL DEMO STYLE, NOT IMPORTANT TO MAKE THINGS WORK BUT TO MAKE IT A BIT NICER :)
*/

/*@font-face{
    font-family: 'Segoe UI';
    src: url("./assets/font/SegoeUI/segoeui.ttf");
}

@import "./assets/font/SegoeUI/segoeui.ttf";*/
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #fafafa;
}
p {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 1.1em;
    font-weight: 300;
    line-height: 1.7em;
    color: #999;
}
a, a:hover, a:focus {
    color: inherit;
    text-decoration: none;
    transition: all 0.3s;
}

.sidebar .sidebar-header {
    padding: 20px;
    background: var(--colors-sidebar-text);
}
.sidebar ul.components {
    padding: 20px 0;
    /*border-bottom: 1px solid #47748b;*/
}
.sidebar ul p {
    color: var(--colors-sidebar-text);
    padding: 10px;
}
.sidebar ul li a {
    padding: 10px;
    font-size: 1.1em;
    display: block;
}
.sidebar ul li a:hover {
    color: var(--colors-main);
    background: #fff;
    text-decoration: none;
}

.sidebar ul li a.router-link-exact-active  {
    color: #fff;
    background: var(--colors-main);
}
ul ul a {
    font-size: 0.9em !important;
    padding-left: 30px !important;
    background: var(--colors-sidebar-background);
}
</style>
