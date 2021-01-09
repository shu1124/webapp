import axios from 'axios';

const headers = { 'Content-Type': 'multipart/form-data' };

const state = {
  microposts: []
};

const getters = {
  microposts: state => state.microposts.sort((a, b) => b.id - a.id)
};

const mutations = {
  setPosts: (state, microposts) => (state.microposts = microposts),
  appendPost: (state, micropost) => (state.microposts = [...state.microposts, micropost]),
  removePost: (state, id) =>
    (state.microposts = state.microposts.filter(micropost => micropost.id !== id))
};

const actions = {
  async fetchPosts({ commit }) {
    try {
      const response = await axios.get('api/microposts');
      commit('setPosts', response.data);
    } catch (e) {
      console.error(e);
    }
  },
  async createPost({ commit }, micropost) {
    try {
      const response = await axios.post('api/microposts', micropost, headers);
      commit('appendPost', response.data);
    } catch (e) {
      console.error(e);
    }
  },
  async deletePost({ commit }, id) {
    try {
      axios.delete(`api/microposts/${id}`);
      commit('removePost', id);
    } catch (e) {
      console.error(e);
    }
  }
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};