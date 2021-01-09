<template>
  <div>
    <div>
      <div v-if="following_check">
        <v-btn color="primary" @click="deleteFollow()" depressed >
          フォロー中
        </v-btn>
      </div>
      <div v-else>
        <v-btn color="primary" depressed outlined @click="registerFollow()">
          フォローする
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { csrfToken } from 'rails-ujs';
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken();

export default {
  // eslint-disable-next-line vue/require-prop-types
  props: ['userId'],
  data() {
    return {
      followList: [],
      following_check: ''
    };
  },
  computed: {
    // eslint-disable-next-line vue/return-in-computed-property
    isFollow(){
      if (this.followList.length === 0) { return false; }
    }
  },
  created() {
    this.fetchFollowing();
  },
  methods: {
    async fetchFollowing() {
      const res = await axios.get('/api/users/2/following');
      if (res.data.users.id) { 
        this.following_check = true;
      } else {
        this.following_check =false;
      }
    },
    async registerFollow() {
      await axios.post('/api/relationships/', { following_id: this.userId });
      this.following_check = true;
    },
    async deleteFollow() {
      await axios.delete('/api/relationships/1', {  user_id: this.userId });
      this.following_check =false;
    },
    findFollowId () {
      const follow = this.followList.find((following) => {
        return (following.user_id === this.userId);
      });
      if (follow) { return follow.id; }
    }
  }
};
</script>
