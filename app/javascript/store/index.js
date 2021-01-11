import Vue from 'vue';
import Vuex from 'vuex';
import auth from '@/store/modules/auth';
import microposts from '@/store/modules/microposts';
Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    auth,
    microposts
  }
});

export default store; 