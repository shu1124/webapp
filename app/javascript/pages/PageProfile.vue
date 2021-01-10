<template>
  <v-container>
    <v-row>
      <v-col>
        <v-card
                max-width="800"
                class="mx-auto"
                v-if="user"
        >
          <v-card-title>

            <v-avatar size="120">
              <v-img
                      :src="user.avatar_url"
                      aspect-ratio="1"
                      class="grey lighten-2"
              >
                <template v-if="isMe">
                  <v-row
                          class="fill-height ma-0"
                          align="center"
                          justify="center"
                  >
                    <v-btn icon @click="$refs.avatarUploadDialog.toggleShow()" style="width: 100%; height: 100%;">
                      <v-icon color="secondary">mdi-camera</v-icon>
                    </v-btn>
                  </v-row>
                </template>
              </v-img>
            </v-avatar>

            <avatar-upload ref="avatarUploadDialog"></avatar-upload>

            <v-spacer></v-spacer>
            <v-btn v-if="isMe" class="ma-2" tile outlined color="success" @click="$refs.dialog.open()">
              <v-icon left>mdi-pencil</v-icon> プロフィール編集
            </v-btn>
            <follow-button v-if="isLogin" class="ma-2" tile outlined color="success" :user-id="user.id"></follow-button>
          </v-card-title>

          <v-list>
            <v-list-item >
              <v-list-item-icon>
                <v-icon color="indigo">mdi-account</v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-list-item-title>{{user.name}}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-divider inset></v-divider>

            <v-list-item>
              <v-list-item-icon>
                <v-icon color="indigo">mdi-email</v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-list-item-title>{{user.email}}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-divider inset></v-divider>

            <v-list-item>
              <v-list-item-icon>
                <v-icon color="indigo">mdi-account-details</v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-list-item-title>
            <span style="white-space: pre-line">
              {{user.introduction}}
            </span>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-divider inset></v-divider>

            <v-list-item >
              <v-list-item-icon>
                <v-icon color="indigo">mdi-music-accidental-sharp</v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-list-item-title>
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
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <profile-edit-modal v-if="isMe" ref="dialog"></profile-edit-modal>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import axios from 'axios'
  import ProfileEditModal from "@/components/ProfileEditModal";
  import AvatarUpload from "@/components/AvatarUpload";
  import FollowButton from "@/components/FollowButton";
  export default {
      data() {
          return {
              targetUser: null,
          }
      },
      components: {
          ProfileEditModal,
          AvatarUpload,
          FollowButton
      },
      computed: {
          isMe() {
              return this.$store.getters['auth/currentUser'] && this.userId == this.$store.getters['auth/currentUser'].id
          },
          isLogin() {
              return this.$store.getters['auth/currentUser'] && this.userId ==! this.$store.getters['auth/currentUser'].id
          },
          userId() {
              return this.$route.params.id || this.$store.getters['auth/currentUser'].id
          },
          user() {
              return this.isMe ? this.$store.getters['auth/currentUser'] : this.targetUser
          }
      },
      async created() {
          if (this.isMe) return
          const res = await axios.get(`/api/users/${this.userId}`)
          this.targetUser = res.data.user
      },
  }
</script>