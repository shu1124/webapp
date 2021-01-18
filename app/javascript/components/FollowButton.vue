<template>
  <div>
    <div 
      v-if="isFollowed"
      @click="deleteFollow()"
    >
      <v-btn 
        class="ma-2" 
        tile 
        color="indigo"
      >
        <v-icon 
          left
        >
          mdi-plus
        </v-icon> 
        フォローを解除する
      </v-btn>
    </div>
    <div 
      v-else
      @click="registerFollow()"
    >
      <v-btn 
        class="ma-2" 
        tile 
        outlined 
        color="indigo"
      >
        <v-icon 
          left
        >
          mdi-plus
        </v-icon> 
        フォローする
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
  props: ['userId'],
  data() {
    return {
      followList: [],
      follow: [],
      relationshipId: '',
    };
  },
  computed: {
    isFollowed() {
      if (this.follow === 0) { return false; } 
      else {return true; }
    }
  },
  created() {
    this.fetchFollowByUserId().then(result => {
      this.followList = result;
      this.follow = result.relationships.length;
      if( this.follow === 1 ){
        this.relationshipId = result.relationships[0].id;
        console.log(this.relationshipId);
      }
    });
  },
  methods: {
    async fetchFollowByUserId() {
      const res = await axios.get(`/api/relationships/?user_id=${this.userId}`);
      // eslint-disable-next-line no-undef
      if (res.status !== 200) { process.exit(); }
      return res.data;
    },
    async registerFollow() {
      await axios.post('/api/relationships', { following_id: this.userId });
      // eslint-disable-next-line no-undef
      this.fetchFollowByUserId().then(result => {
        this.followList = result;
        this.follow = result.relationships.length;
        if( this.follow === 1 ){
          this.relationshipId = result.relationships[0].id;
          console.log(this.relationshipId);
        }
      });
    },
    async deleteFollow() {
      await axios.delete(`/api/relationships/${this.relationshipId}`);
      // eslint-disable-next-line no-undef
      this.fetchFollowByUserId().then(result => {
        this.followList = result;
        this.follow = result.relationships.length;
      });
    }
  }
};
</script>