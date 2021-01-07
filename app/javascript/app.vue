<template>
  <v-app id="inspire">
    <v-navigation-drawer
            v-model="drawer"
            app
    >
      <v-list dense>
        <v-list-item to="/" link>
          <v-list-item-action>
            <v-icon>mdi-home</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ホーム</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item to="/users" link>
          <v-list-item-action>
            <v-icon>mdi-account-group</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ユーザー</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item :to="`/users/${$store.getters['auth/currentUser'].id}`" link v-if="$store.getters['auth/currentUser']">
          <v-list-item-action>
            <v-icon>mdi-account</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>プロフィール</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item :to="`/micropost`" link v-if="$store.getters['auth/currentUser']">
          <v-list-item-action>
            <v-icon>mdi-comment</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>投稿する</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item link v-if="$store.getters['auth/currentUser']">
          <v-list-item-action>
            <v-icon>mdi-logout</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title @click="logout">ログアウト</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item to="/login" link v-else>
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
      color="blue-grey lighten-2"
      dark
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

      <v-toolbar-title>Application</v-toolbar-title>

      <v-spacer></v-spacer>

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
            <router-view></router-view>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
    <v-footer
            color="blue-grey lighten-2"
            app
    >
      <span class="white--text">&copy; 2021</span>
    </v-footer>
  </v-app>
</template>

<script>
  export default {
    props: {
      source: String,
    },
    data: () => ({
      drawer: null,
    }),
    methods: {
      logout() {
        if (confirm("ログアウトしますか？")) {
          this.$store.dispatch('auth/logout')
        }
      }
    }
  }
</script>