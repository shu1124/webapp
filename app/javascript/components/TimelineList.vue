<template>
    <v-row>
      <v-col
        v-for="micropost in microposts" :key="micropost.id" :micropost="micropost"
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
            <v-card-title >
              <v-list-item-avatar @click="$router.push(`/users/${micropost.user.id}`)">
                <v-img :src="micropost.user.avatar_url"></v-img>
              </v-list-item-avatar>
                {{ micropost.user.name }}
            </v-card-title>
          </v-img>
          <v-card-subtitle class="pb-0">
            <v-list-item-action-text v-text="$dayjs(micropost.created_at).format('YYYY-MM-DD HH:mm:ss')"></v-list-item-action-text>
          </v-card-subtitle>
          <v-card-text class="text--primary">
            <v-list-item-subtitle style="white-space: pre-line">
              タイトル: {{ micropost.title }}
              勉強時間： {{ micropost.time}} h
            </v-list-item-subtitle>
          </v-card-text>
        </v-card>
      </v-col>
   </v-row>
</template>

<script>
    export default {
        props: {
            microposts: {
                type: Array,
                default: []
            }
        },
    }
</script>