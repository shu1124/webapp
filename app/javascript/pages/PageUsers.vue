<template>
  <v-container>
    <template>
      <v-card class="mb-3">
        <v-card-text>
          <header>絞り込み条件</header>
          <v-row dense justify="start">
            <template>
              <v-checkbox v-for="tag in tags"
                          :key="tag.id"
                          v-model="query.selectedTags"
                          :label="tag.name"
                          :value="tag.id"
                          class="mr-5"
                          @click.native="fetchUsers"
                          hide-details="auto"
              >
              </v-checkbox>
            </template>
          </v-row>
          <v-row>
            <template>
              <v-col cols="12">
                <v-text-field label="UserName" v-model="query.userName" @input="fetchUsers"></v-text-field>
              </v-col>
            </template>
          </v-row>
        </v-card-text>
      </v-card>
    </template>
    <v-row dense>
      <v-col
              v-for="user in users"
              :key="user.id"
              :cols="6"
              :md="3"
      >
        <v-card>
          <v-img
                  :src="`http://placeimg.com/300/300/people?dummy=${user.id}`"
                  :lazy-src="`https://picsum.photos/10/6?dummy=${user.id}`"
                  class="white--text align-end"
                  gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                  aspect-ratio="1"
          >
            <template v-slot:placeholder>
              <v-row
                      class="fill-height ma-0"
                      align="center"
                      justify="center"
              >
                <v-progress-circular indeterminate color="grey lighten-5"></v-progress-circular>
              </v-row>
            </template>
            <v-card-title v-text="user.name" @click="$router.push(`/users/${user.id}`)" style="cursor: pointer;"></v-card-title>
          </v-img>

          <v-card-text class="text--primary" style="min-height: 64px;">
            <v-chip
                    class="ma-1"
                    color="orange"
                    text-color="white"
                    small
                    v-for="tag in user.tags" :key="tag.name"
            >
              <v-icon left class="mr-0">mdi-music-accidental-sharp</v-icon>
              {{tag.name}}
            </v-chip>
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn icon>
              <v-icon>mdi-heart</v-icon>
            </v-btn>

            <v-btn icon>
              <v-icon>mdi-bookmark</v-icon>
            </v-btn>

            <v-btn icon>
              <v-icon>mdi-share-variant</v-icon>
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
    <v-row justify="center" class="pb-10">
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
    </v-row>
  </v-container>
</template>

<script>
  import axios from 'axios'
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
          }
      },
      created() {
          this.fetchUsers()
          this.fetchTags()
      },
      methods: {
          async fetchUsers() {
              const searchParams = {
                  q: {
                      name: this.query.userName,
                      tag_ids: this.query.selectedTags
                  }
              }
              const pagingParams = { page: this.currentPage }
              const params = { ...searchParams, ...pagingParams }
              const paramsSerializer = (params) => qs.stringify(params, { arrayFormat: 'brackets' });
              const res = await axios.get(`/api/users`, { params, paramsSerializer })
              this.users = res.data.users
              this.pagingMeta = res.data.meta
          },
          async fetchTags() {
              const res = await axios.get(`/api/tags`)
              this.tags = res.data.tags
          },
          paging(page) {
              this.currentPage = page
              this.fetchUsers()
              this.$vuetify.goTo(0)
          }
      }
  }
</script>