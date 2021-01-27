<template>
  <v-container>
    <v-card class="mb-3">
      <v-card-text>
        <header>ジャンルタグで絞り込み</header>
        <v-row 
          dense 
          justify="start"
        >
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
        </v-row>
        <v-row>
          <v-col cols="12">
            <v-text-field 
              v-model="query.micropostTitle" 
              label="タイトルで検索" 
              @input="fetchMicroposts"
            />
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
    <v-sheet height="50" />
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
            <like-button
              v-if="user" 
              :user-id="userId"
              :micropost-id="micropost.id"
            />
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
    <v-sheet height="100" />
    <v-row>
      <v-col>
        <v-spacer />
        <template 
          v-if="pagingMeta" 
          class="mr-5"
        >
          <div class="text-center mr-5">
            <v-pagination
              v-model="pagingMeta.current_page"
              color="indigo"
              :length="pagingMeta.total_pages"
              @input="paging"
            />
          </div>
        </template>
      </v-col>
      <v-sheet height="100" />
    </v-row>
    <v-layout 
      v-if="user" 
      column
      class="fab-container" 
    >
      <v-btn
        class="ma-2"
        outlined
        large
        fab
        color="indigo"
        @click="openEditMicropost"
      >
        <v-icon>mdi-pencil</v-icon>
      </v-btn>
      <micropost-post-modal 
        ref="dialog"
        @upload="uploadMicropost"
      />
    </v-layout>
  </v-container>
</template>

<script>
import LikeButton from '@/components/LikeButton';
import MicropostPostModal from '@/components/MicropostPostModal';
import axios from 'axios';
import qs from 'qs';
export default {
  components: {
    MicropostPostModal,
    LikeButton
  },
  data() {
    return {
      microposts: [],
      genres: [],
      query: {
        selectedGenres: [],
        micropostTitle: ''
      },
      pagingMeta: null,
      currentPage: 1
    };
  },
  computed: {
    isExistMicroposts() {
      return this.microposts.length > 0;
    },
    isMe() {
      return this.$store.getters['auth/currentUser'] && this.userId == this.$store.getters['auth/currentUser'].id;
    },
    userId() {
      return this.$route.params.id || this.$store.getters['auth/currentUser'].id;
    },
    user() {
      return this.isMe ? this.$store.getters['auth/currentUser'] : this.targetUser;
    },
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
          title: this.query.micropostTitle,
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
    },
    openEditMicropost() {
      this.$refs.dialog.open();
    },
    async uploadMicropost(formData) {
      await axios.post('/api/microposts/', formData);
      this.$refs.dialog.close();
      this.fetchMicroposts();
      this.$refs.form.reset();
    },
  }
};
</script>

<style>
  .fab-container {
    position: fixed;
    bottom: 100px;
    right: 100px;
  }
</style>