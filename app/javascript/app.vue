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
        <v-list-item link v-if="$store.getters['auth/currentUser']">
          <v-list-item-action>
            <v-icon>mdi-account</v-icon>
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
            color="indigo"
            dark
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title>Application</v-toolbar-title>
    </v-app-bar>

    <v-main>
      <router-view></router-view>
    </v-main>
    <v-footer
            color="indigo"
            app
    >
      <span class="white--text">&copy; 2019</span>
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