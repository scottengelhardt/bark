// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import Vuetify from 'vuetify'
import VTooltip from 'v-tooltip'
import 'vuetify/dist/vuetify.min.css'
Vue.config.productionTip = false
Vue.use(Vuetify)
VTooltip.enabled = window.innerWidth > 540
Vue.use(VTooltip)
VTooltip.options.defaultClass = 'tooltip'

Vue.config.ignoredElements = [/^icon/] // suppress vue warning for <icon> tag not being installed

new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
