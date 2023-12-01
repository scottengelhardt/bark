import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin'
import Welcome from '@/components/Welcome'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Signin,
    },
    {
      path: '/welcome',
      component: Welcome,
    },
  ]
})
