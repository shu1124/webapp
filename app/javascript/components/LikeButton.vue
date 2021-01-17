<template>
  <div>
    <div 
      v-if="isLiked" 
      @click="deleteLike()"
    >
      <v-btn 
        icon 
        color="pink"
      > 
        <v-icon> mdi-heart </v-icon>
      </v-btn> 
    </div>
    <div 
      v-else 
      @click="registerLike()"
    >
      <v-btn icon> 
        <v-icon>mdi-heart</v-icon>
      </v-btn>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { csrfToken } from 'rails-ujs';
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken();

export default {
  // eslint-disable-next-line vue/require-prop-types
  props: ['userId', 'micropostId'],
  data() {
    return {
      likeList: [],
      likes:[],
      likeId: ''
    };
  },
  computed: {
    isLiked() {
      if (this.likes === 0) { return false; } 
      else {return true; }
    }
  },
  created() {
    this.fetchLikeByPostId().then(result => {
      this.likeList = result;
      this.likes = result.likes.length;
      if( this.likes === 1 ){
        this.likeId = result.likes[0].id;
        console.log(this.likeId);
      }
    });
  },
  methods: {
    async fetchLikeByPostId() {
      const res = await axios.get(`/api/likes/?micropost_id=${this.micropostId}`);
      // eslint-disable-next-line no-undef
      if (res.status !== 200) { process.exit(); }
      return res.data;
    },
    async registerLike() {
      const res = await axios.post('/api/likes', { micropost_id: this.micropostId });
      // eslint-disable-next-line no-undef
      if (res.status !== 201) { process.exit(); }
      this.fetchLikeByPostId().then(result => {
        this.likeList = result;
        this.likes = result.likes.length;
        if( this.likes === 1 ){
          this.likeId = result.likes[0].id;
          console.log(this.likeId);
        }
      });
    },
    async deleteLike() {
      await axios.delete(`/api/likes/${this.likeId}`);
      // eslint-disable-next-line no-undef
      this.fetchLikeByPostId().then(result => {
        this.likeList = result;
        this.likes = result.likes.length;
      });
    }
  }
};
</script>