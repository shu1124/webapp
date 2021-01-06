<template>
  <v-container>
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
                  class="white--text align-end"
                  gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
          >
            <v-card-title v-text="user.name"></v-card-title>
          </v-img>

          <v-card-text class="text--primary">
            <div>#Ruby</div>
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
  </v-container>
</template>

<script>
  import axios from 'axios'
  export default {
      data() {
          return {
              users: []
          }
      },
      created() {
          this.fetchUsers()
      },
      methods: {
          async fetchUsers() {
              const res = await axios.get(`/api/users`)
              this.users = res.data.users
          }
      }
  }
</script>