<template>
  <v-container>
    <v-card class="mb-3">
      <v-card-text>
        <header>ユーザータグで絞り込み</header>
        <v-row 
          dense
          justify="start"
        >
          <v-checkbox 
            v-for="tag in tags"
            :key="tag.id"
            v-model="query.selectedTags"
            :label="tag.name"
            :value="tag.id"
            class="mr-5"
            hide-details="auto"
            @click.native="fetchUsers"
          />
        </v-row>
        <v-row>
          <v-col cols="12">
            <v-text-field 
              v-model="query.userName" 
              label="ユーザー名で検索" 
              @input="fetchUsers"
            />
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
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
    <v-row>
      <v-col>
        <v-sheet height="100" />
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
        <v-sheet height="100" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';
import qs from 'qs';
export default {
  data() {
    return {
      users: [],
      tags: [],
      query: {
        selectedTags: [],
        userName: ''
      },
      pagingMeta: null,
      currentPage: 1
    };
  },
  created() {
    this.fetchUsers();
    this.fetchTags();
  },
  methods: {
    async fetchUsers() {
      const searchParams = {
        q: {
          name: this.query.userName,
          tag_ids: this.query.selectedTags
        }
      };
      const pagingParams = { page: this.currentPage };
      const params = { ...searchParams, ...pagingParams };
      const paramsSerializer = (params) => qs.stringify(params, { arrayFormat: 'brackets' });
      const res = await axios.get('/api/users', { params, paramsSerializer });
      this.users = res.data.users;
      this.pagingMeta = res.data.meta;
    },
    async fetchTags() {
      const res = await axios.get('/api/tags');
      this.tags = res.data.tags;
    },
    paging(page) {
      this.currentPage = page;
      this.fetchUsers();
      this.$vuetify.goTo(0);
    }
  }
};
</script>