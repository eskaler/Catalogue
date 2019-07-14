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
      path: '/cart',
      name: 'cart',
      component: () => import(/* webpackChunkName: "contacts" */ './views/Cart.vue')
    },
    {
      path: '/admin',
      name: 'admin',
      component: () => import(/* webpackChunkName: "contacts" */ './views/Admin.vue'),
      children: [
        {
          path: 'signin',
          name: 'singin',
          component: () => import(/* webpackChunkName: "contacts" */ './views/SignIn.vue')
        },
        {
          path: 'panel',
          name: 'panel',
          component: () => import(/* webpackChunkName: "contacts" */ './views/Panel.vue')
        },
      ]
    },
    
  ]
})
