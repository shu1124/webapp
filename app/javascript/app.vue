<template>
  <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      app
    >
      <v-list v-if="$store.getters['auth/currentUser']">
        <v-list-item class="grow">
          <v-list-item-avatar 
            v-if="user"
            color="grey darken-3"
          >
            <v-img
              class="elevation-6"
              :src="user.avatar_url"
            />
          </v-list-item-avatar>

          <v-list-item-content v-if="user">
            <v-list-item-title>
              <div>
                <v-list-item-subtitle>follow</v-list-item-subtitle>
                <v-list-item-title class="title" @click="$router.push('/follow')">
                  <follow-count
                    :user-id="user.id"
                    @click="$router.push('/follow')"
                  />
                </v-list-item-title>
              </div>
            </v-list-item-title>
          </v-list-item-content>
          <v-list-item-content v-if="user">
            <v-list-item-title>
              <div>
                <v-list-item-subtitle>follower</v-list-item-subtitle>
                <v-list-item-title class="title" @click="$router.push('/follower')">
                  <follower-count
                    :user-id="user.id"
                  />
                </v-list-item-title>
              </div>
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item v-if="user">
          <v-list-item-content>
            <v-list-item-title class="title">
              {{ user.name }}
            </v-list-item-title>
            <v-list-item-subtitle>{{ user.email }}</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>
      <v-divider />
      <v-list dense>
        <v-list-item 
          to="/"
          link
        >
          <v-list-item-action>
            <v-icon>mdi-home</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>すべての投稿</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item 
          to="/profile"
          link
        >
          <v-list-item-action>
            <v-icon>mdi-account-group</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ユーザーを探す</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        
        <v-list-item 
          v-if="$store.getters['auth/currentUser']" 
          :to="`/users/${$store.getters['auth/currentUser'].id}`"
          link
        >
          <v-list-item-action>
            <v-icon>mdi-account</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>マイページ</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item 
          v-if="$store.getters['auth/currentUser']" 
          to="/like"
          link
        >
          <v-list-item-action>
            <v-icon>mdi-heart</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>お気に入り</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        
        <v-list-item 
          v-if="$store.getters['auth/currentUser']"
          link
        >
          <v-list-item-action>
            <v-icon>mdi-logout</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title @click="logout">
              ログアウト
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item 
          v-else 
          to="/login" 
          link
        >
          <v-list-item-action>
            <v-icon>mdi-account</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ログイン</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar
      app
      shrink-on-scroll
      color="blue-grey"
      dark
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />

      <v-toolbar-title>SELF MBA</v-toolbar-title>

      <v-spacer />
    </v-app-bar>

    <v-main>
      <v-container
        class="fill-height"
        fluid
      >
        <v-row
          align="center"
          justify="center"
        >
          <v-col>
            <router-view />
          </v-col>
        </v-row>
      </v-container>
    </v-main>
    <v-footer
      color="blue-grey"
      app
    >
      <span class="white--text">&copy; 2021</span>
    </v-footer>
  </v-app>
</template>

<script>
import FollowCount from '@/components/FollowCount';
import FollowerCount from '@/components/FollowerCount';
export default {
  components: {
    FollowCount,
    FollowerCount
  },
  props: {
    // eslint-disable-next-line vue/require-default-prop
    source: String,
  },
  data: () => ({
    drawer: null,
    targetUser: null,
    following: []
  }),
  computed: {
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
  methods: {
    logout() {
      if (confirm('ログアウトしますか？')) {
        this.$store.dispatch('auth/logout');
      }
      this.$router.push('/');
    },
  }
};
</script>