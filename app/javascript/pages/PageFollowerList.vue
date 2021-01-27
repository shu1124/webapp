<template>
  <v-container>
    <v-row 
      class="text-center"
    >
      <v-col>
        <h1>フォローされたユーザー一覧</h1>
      </v-col>
    </v-row>
    <v-sheet height="50" />
    <v-row dense>
      <v-col
        v-for="user in users"
        :key="user.id"
        :cols="6"
        :md="3"
      >
        <v-card>
          <v-img
            :src="user.avatar_url"
            class="white--text align-end"
            gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
            aspect-ratio="1"
          >
            <template #placeholder>
              <v-row
                class="fill-height ma-0"
                align="center"
                justify="center"
              >
                <v-progress-circular 
                  indeterminate 
                  color="grey lighten-5"
                />
              </v-row>
            </template>
            <v-card-title 
              style="cursor: pointer;"
              @click="$router.push(`/users/${user.id}`)" 
              v-text="user.name"
            />
          </v-img>

          <v-card-text 
            class="text--primary" 
            style="min-height: 64px;"
          >
            <v-chip
              v-for="tag in user.tags"
              :key="tag.name"
              class="ma-1"
              color="orange"
              text-color="white"
              small
            >
              <v-icon 
                left 
                class="mr-0"
              >
                mdi-music-accidental-sharp
              </v-icon>
              {{ tag.name }}
            </v-chip>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-sheet height="100" />
  </v-container>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      users: [],
    };
  },
  computed: {
    isMe() {
      return this.$store.getters['auth/currentUser'] && this.userId == this.$store.getters['auth/currentUser'].id;
    },
    isLogin() {
      return this.$store.getters['auth/currentUser'] && this.userId !== this.$store.getters['auth/currentUser'].id;
    },
    userId() {
      return this.$route.params.id || this.$store.getters['auth/currentUser'].id;
    },
  },
  created() {
    this.fetchUsers();
  },
  methods: {
    async fetchUsers() {
      const res = await axios.get(`/api/users/${this.userId}/followers/`);
      this.users = res.data.users;
    }
  }
};
</script>