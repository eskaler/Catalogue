import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/products',
      name: 'products',
      component: () => import(/* webpackChunkName: "contacts" */ './views/Products.vue')
    },
    {
      path: '/contacts',
      name: 'contacts',
      component: () => import(/* webpackChunkName: "contacts" */ './views/Contacts.vue')
    },
    {
      path: '/signin',
      name: 'singin',
      component: () => import(/* webpackChunkName: "contacts" */ './views/SignIn.vue')
    },
    {
      path: '/cart',
      name: 'cart',
      component: () => import(/* webpackChunkName: "contacts" */ './views/Cart.vue')
    }
  ]
})
