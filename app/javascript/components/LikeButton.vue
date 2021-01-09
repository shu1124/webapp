<template>
  <div>
    <div v-if="isLiked" @click="deleteLike()">
      <v-btn icon color="pink"> <v-icon>mdi-heart</v-icon></v-btn>{{ count }}
    </div>
    <div v-else @click="registerLike()">
      <v-btn icon> <v-icon>mdi-heart</v-icon></v-btn>{{ count }}
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { csrfToken } from 'rails-ujs';
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken();

export default {
  props: ['userId', 'micropostId'],
  data() {
    return {
      likeList: []
    };
  },
  computed: {
    count() {
      return this.likeList.length;
    },
    isLiked() {
      if (this.likeList.length === 0) { return false; }
      return Boolean(this.findLikeId());
    }
  },
  created() {
    this.fetchLikeByPostId().then(result => {
      this.likeList = result;
    });
  },
  methods: {
    async fetchLikeByPostId() {
      const res = await axios.get(`/api/microposts/${this.micropostId}/likes`);
      // eslint-disable-next-line no-undef
      if (res.status !== 200) { process.exit(); }
      return res.data;
    },
    async registerLike() {
      const res = await axios.post(`/api/microposts/${this.micropostId}/likes`, { micropost_id: this.micropostId });
      // eslint-disable-next-line no-undef
      if (res.status !== 201) { process.exit(); }
      this.fetchLikeByPostId().then(result => {
        this.likeList = result;
      });
    },
    deleteLike: async function() {
      const likeId = this.findLikeId();
      const res = await axios.delete(`/api/microposts/${this.micropostId}/likes/${likeId}`);
      // eslint-disable-next-line no-undef
      if (res.status !== 200) { process.exit(); }
      this.likeList = this.likeList.filter(n => n.id !== likeId);
    },
    findLikeId: function() {
      const like = this.likeList.find((like) => {
        return (like.user_id === this.userId);
      });
      if (like) { return like.id; }
    }
  }
};
</script>