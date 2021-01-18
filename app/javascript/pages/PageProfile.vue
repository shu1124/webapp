<template>
  <div>
    <v-container>
      <v-row 
        class="text-center"
      >
        <v-col v-if="user">
          <h1>{{ user.name }}さんのプロフィール</h1>
        </v-col>
      </v-row>
      <v-sheet height="50" />
      <v-row>
        <v-col>
          <v-card
            v-if="user"
            max-width="800"
            class="mx-auto"
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
                      <v-btn 
                        icon 
                        style="width: 100%; height: 100%;" 
                        @click="$refs.avatarUploadDialog.toggleShow()"
                      >
                        <v-icon color="secondary">
                          mdi-camera
                        </v-icon>
                      </v-btn>
                    </v-row>
                  </template>
                </v-img>
              </v-avatar>
              <avatar-upload 
                ref="avatarUploadDialog"
              />
              <v-spacer />
              <v-btn 
                v-if="isMe" 
                class="ma-2" 
                tile 
                outlined 
                color="success" 
                @click="$refs.dialog.open()"
              >
                <v-icon 
                  left
                >
                  mdi-pencil
                </v-icon> 
                プロフィール編集
              </v-btn>
              <follow-button 
                v-else-if="isLogin"   
                :user-id="user.id"
              />
            </v-card-title>
            <v-list>
              <v-list-item>
                <v-list-item-icon>
                  <v-icon color="indigo">
                    mdi-account
                  </v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>
                    {{ user.name }}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-divider inset />
              <v-list-item>
                <v-list-item-icon>
                  <v-icon color="indigo">
                    mdi-email
                  </v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>
                    {{ user.email }}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-divider inset />
              <v-list-item>
                <v-list-item-icon>
                  <v-icon color="indigo">
                    mdi-account-details
                  </v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>
                    <span style="white-space: pre-line">
                      {{ user.introduction }}
                    </span>
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-divider inset />
              <v-list-item>
                <v-list-item-icon>
                  <v-icon color="indigo">
                    mdi-music-accidental-sharp
                  </v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title>
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
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list>
          </v-card>
          <profile-edit-modal 
            v-if="isMe" 
            ref="dialog"
          />
        </v-col>
      </v-row>
    </v-container>

    <v-sheet height="100" />
    <v-row class="text-center">
      <v-col v-if="user">
        <h1>{{ user.name }}さんの投稿一覧</h1>
      </v-col>
    </v-row>
    <v-sheet height="50" />
    <v-row>
      <v-col
        v-for="micropost in microposts"
        :key="micropost.id" 
        :micropost="micropost"
        cols="3"
        class="mt-2"
      >
        <v-card
          class="mx-auto"
          max-width="250"
        >
          <v-img
            class="white--text align-end"
            height="200px"
            :src="micropost.image_url"
            @click="$router.push(`/microposts/${micropost.id}`)"
          >
            <v-card-title>
              タイトル: {{ micropost.title }}
            </v-card-title>
          </v-img>
        </v-card>
      </v-col>
    </v-row>
    <v-sheet height="100" />
  </div>
</template>

<script>
import axios from 'axios';
import ProfileEditModal from '@/components/ProfileEditModal';
import AvatarUpload from '@/components/AvatarUpload';
import FollowButton from '@/components/FollowButton';

export default {
  components: {
    ProfileEditModal,
    AvatarUpload,
    FollowButton
  },
  data() {
    return {
      targetUser: null,
      microposts: []
    };
  },
  computed: {
    isMe() {
      return this.$store.getters['auth/currentUser'] && this.userId == this.$store.getters['auth/currentUser'].id;
    },
    isLogin() {
      return this.$store.getters['auth/currentUser'] && this.userId !== this.$store.getters['auth/currentUser'].id;
    },
    userId() {
      return this.$route.params.id || this.$store.getters['auth/currentUser'].id;
    },
    user() {
      return this.isMe ? this.$store.getters['auth/currentUser'] : this.targetUser;
    }
  },
  async created() {
    this.fetchMicroposts();
    if (this.isMe) return;
    const res = await axios.get(`/api/users/${this.userId}`);
    this.targetUser = res.data.user;
  },
  methods: {
    async fetchMicroposts() {
      const res = await axios.get(`/api/users/${this.userId}`);
      this.microposts = res.data.user.microposts;
    }
  }
};
</script>