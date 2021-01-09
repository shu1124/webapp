<template>
  <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      app
    >
      <v-list dense>
        <v-list-item 
          to="/"
          link
        >
          <v-list-item-action>
            <v-icon>mdi-home</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ホーム</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item 
          to="/users" 
          link
        >
          <v-list-item-action>
            <v-icon>mdi-account-group</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ユーザー</v-list-item-title>
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
            <v-list-item-title>プロフィール</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item 
          v-if="$store.getters['auth/currentUser']" 
          :to="`/micropost`" 
          link
        >
          <v-list-item-action>
            <v-icon>mdi-comment</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>投稿する</v-list-item-title>
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

      <v-toolbar-title>Application</v-toolbar-title>

      <v-spacer />

      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>
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
export default {
  props: {
    // eslint-disable-next-line vue/require-default-prop
    source: String,
  },
  data: () => ({
    drawer: null,
  }),
  methods: {
    logout() {
      if (confirm('ログアウトしますか？')) {
        this.$store.dispatch('auth/logout');
      }
    }
  }
};
</script>