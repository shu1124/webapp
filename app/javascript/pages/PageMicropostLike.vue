<template>
  <v-container>
    <v-row>
      <v-col
        v-for="micropost in microposts"
        :key="micropost.id" 
        :micropost="micropost"
        cols="4"
      >
        <v-card
          class="mx-auto"
          max-width="400"
        >
          <v-img
            class="white--text align-end"
            height="200px"
            :src="micropost.image_url"
            @click="$router.push(`/microposts/${micropost.id}`)"
          >
            <v-card-title>
              <v-list-item-avatar @click="$router.push(`/users/${micropost.user.id}`)">
                <v-img 
                  :src="micropost.user.avatar_url"
                />
              </v-list-item-avatar>
              {{ micropost.user.name }}
            </v-card-title>
          </v-img>
          <v-card-subtitle class="pb-0">
            <v-list-item-action-text 
              v-text="$dayjs(micropost.created_at).format('YYYY-MM-DD HH:mm:ss')"
            />
          </v-card-subtitle>
          <v-card-text class="text--primary">
            <v-list-item-subtitle style="white-space: pre-line">
              タイトル: {{ micropost.title }}
              勉強時間： {{ micropost.time }} h
            </v-list-item-subtitle>
            <v-spacer />
            <v-chip
              v-for="genre in micropost.genres"
              :key="genre.name"
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
              {{ genre.name }}
            </v-chip>
          </v-card-text>
          <v-card-actions>
            <v-btn icon>
              <like-button 
                :user-id="micropost.user.id"
                :micropost-id="micropost.id"
              />
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import LikeButton from '@/components/LikeButton';
import axios from 'axios';
import qs from 'qs';
export default {
  components: {
    LikeButton
  },
  data() {
    return {
      microposts: [],
      users: [],
      genres: [],
      query: {
        selectedGenres: [],
        userName: ''
      },
      pagingMeta: null,
      currentPage: 1
    };
  },
  computed: {
    isExistMicroposts() {
      return this.microposts.length > 0;
    }
  },
  created() {
    this.fetchUsers();
    this.fetchGenres();
    this.fetchMicroposts();
  },
  methods: {
    async fetchMicroposts() {
      const res = await axios.get('/api/microposts/likes', { params: { page: this.currentPage } });
      this.microposts = res.data.microposts;
      this.pagingMeta = res.data.meta;
    },
    async fetchUsers() {
      const searchParams = {
        q: {
          name: this.query.userName,
          genre_ids: this.query.selectedGenres
        }
      };
      const pagingParams = { page: this.currentPage };
      const params = { ...searchParams, ...pagingParams };
      const paramsSerializer = (params) => qs.stringify(params, { arrayFormat: 'brackets' });
      const res = await axios.get('/api/users', { params, paramsSerializer });
      this.users = res.data.users;
      this.pagingMeta = res.data.meta;
    },
    async fetchGenres() {
      const res = await axios.get('/api/genres');
      this.genres = res.data.genres;
    },
    paging(page) {
      this.currentPage = page;
      this.fetchUsers();
      this.$vuetify.goTo(0);
    }
  }
};
</script>