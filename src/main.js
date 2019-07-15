import Vue from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios';

import 'bootstrap';
import 'jquery';
import 'popper.js';
import './assets/app.scss';

//font-awesome setup
import { library } from '@fortawesome/fontawesome-svg-core';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { ClientTable, Event } from 'vue-tables-2';
library.add(fas);
Vue.component('font-awesome-icon', FontAwesomeIcon);

import './assets/fluent-design-bootstrap/css/fluent.css';

Vue.config.productionTip = false;
Vue.use(VueAxios, axios);
Vue.use(ClientTable, theme = 'bootstrap4')

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
