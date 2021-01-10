<template>
  <v-container>
    <template>
      <v-card class="mb-3">
        <v-card-text>
          <header>絞り込み条件</header>
          <v-row 
            dense 
            justify="start"
          >
            <template>
              <v-checkbox 
                v-for="genre in genres"
                :key="genre.id"
                v-model="query.selectedGenres"
                :label="genre.name"
                :value="genre.id"
                class="mr-5"
                hide-details="auto"
                @click.native="fetchMicroposts"
              />
            </template>
          </v-row>
          <v-row>
            <template>
              <v-col cols="12">
                <v-text-field 
                  v-model="query.micropostGenre" 
                  label="Genre" 
                  @input="fetchMicroposts"
                />
              </v-col>
            </template>
          </v-row>
        </v-card-text>
      </v-card>
    </template>
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
    <v-spacer />
    <v-spacer />
    <v-spacer />
    <v-spacer />
    <template v-if="pagingMeta">
        <div class="text-center">
            <v-pagination
              color="indigo"
              v-model="pagingMeta.current_page"
              :length="pagingMeta.total_pages"
              @input="paging"
            ></v-pagination>
        </div>
    </template>
    
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
      genres: [],
      query: {
        selectedGenres: [],
        micropostGenre: ''
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
    this.fetchMicroposts();
    this.fetchGenres();
    this.fetchMicroposts();
  },
  methods: {
    async fetchMicroposts() {
      const searchParams = {
        q: {
          name: this.query.micropostGenre,
          genre_ids: this.query.selectedGenres
        }
      };
      const pagingParams = { page: this.currentPage };
      const params = { ...searchParams, ...pagingParams };
      const paramsSerializer = (params) => qs.stringify(params, { arrayFormat: 'brackets' });
      const res = await axios.get('/api/microposts', { params, paramsSerializer });
      this.microposts = res.data.microposts;
      this.pagingMeta = res.data.meta;
    },
    async fetchGenres() {
      const res = await axios.get('/api/genres');
      this.genres = res.data.genres;
    },
    paging(page) {
      this.currentPage = page;
      this.fetchMicroposts();
      this.$vuetify.goTo(0);
    }
  }
};
</script>