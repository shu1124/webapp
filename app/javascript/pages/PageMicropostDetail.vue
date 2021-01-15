<template>
  <v-row>
    <v-col
      cols="12"
      sm="6"
    >
      <div v-if="micropost">
        <v-card
          max-width="1000"
          class="mx-auto"
        >
          <v-img
            :src="micropost.image_url"
            height="500px"
            dark
          >
            <v-row>
              <v-spacer />
              <v-card-title>
                <div 
                  v-if="isMine" 
                  class="d-flex"
                >
                  <v-btn 
                    outlined 
                    fab 
                    large 
                    dark 
                    color="teal" 
                    class="mx-3" 
                    @click="openEditMicropost"
                  >
                    <v-icon>mdi-pen</v-icon>
                  </v-btn>
                  <v-btn 
                    outlined 
                    fab 
                    large 
                    dark 
                    color="error" 
                    class="mx-4" 
                    @click="deleteMicropost"
                  >
                    <v-icon>mdi-delete</v-icon>
                  </v-btn>
                  <micropost-edit-modal 
                    v-if="isMine" 
                    ref="dialog" 
                    :micropost="micropost" 
                    @update="updateMicropost"
                  />
                </div>
              </v-card-title>
            </v-row>
          </v-img>
          <v-list two-line>
            <v-list-item>
              <v-list-item-icon>
                <v-icon color="indigo">
                  mdi-account
                </v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-list-item-subtitle>投稿者</v-list-item-subtitle>
                <v-list-item-title>{{ micropost.user.name }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-divider inset />
            <v-list-item>
              <v-list-item-icon>
                <v-icon color="indigo">
                  mdi-format-title
                </v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-subtitle>タイトル</v-list-item-subtitle>
                <v-list-item-title>{{ micropost.title }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-divider inset />
            <v-list-item>
              <v-list-item-icon>
                <v-icon color="indigo">
                  mdi-clock-outline
                </v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-list-item-subtitle>勉強時間</v-list-item-subtitle>
                <v-list-item-title>{{ micropost.time }}h</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-divider inset />
            <v-list-item>
              <v-list-item-icon>
                <v-icon color="indigo">
                  mdi-comment
                </v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-subtitle>本文</v-list-item-subtitle>
                {{ micropost.content }}
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-card>
      </div>
    </v-col>
    <v-col
      cols="12"
      sm="6"
    >
      <v-card
        max-width="800"
        class="mx-auto"
      >
        <v-subheader>
          コメント
        </v-subheader>
        <v-divider />
        <v-list 
          v-for="comment in comments" 
          :key="comment.id" 
          three-line
        >
          <v-list-item>
            <v-list-item-avatar>
              <v-img 
                :src="comment.user.avatar_url"
              />
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-subtitle v-text="$dayjs(micropost.created_at).format('YYYY-MM-DD HH:mm:ss')" />
              <v-list-item-title>{{ comment.content }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-divider />
        </v-list>
        <v-textarea
          v-model="content"
          class="ma-2"
          outlined
          color="indigo"
          name="input-7-2"
          label="コメント"
          prepend-icon="mdi-comment"
        />
        <div class="text-center">
          <v-btn 
            class="ma-1" 
            depressed 
            color="primary" 
            @click="upload"
          >
            コメント
          </v-btn>
        </div>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import axios from 'axios';
import MicropostEditModal from '@/components/MicropostEditModal';
export default {
  components: {
    MicropostEditModal,
  },
  data() {
    return {
      micropost: null,
      comments: [],
      content: ''
    };
  },
  computed: {
    micropostId() {
      return this.$route.params.id;
    },
    isMine() {
      if(!this.$store.getters['auth/currentUser']) return false;
      return this.micropost.user.id == this.$store.getters['auth/currentUser'].id;
    }
  },
  created() {
    this.fetchMicropost(),
    this.fetchComment();
  },
  methods: {
    async fetchMicropost() {
      const res = await axios.get(`/api/microposts/${this.micropostId}`);
      this.micropost = res.data.micropost;
    },
    openEditMicropost() {
      this.$refs.dialog.open();
    },
    async updateMicropost(micropostParams) {
      await axios.patch(`/api/microposts/${this.micropostId}`, micropostParams);
      this.$refs.dialog.close();
    },
    async deleteMicropost() {
      if(confirm('削除しますか？')) {
        await axios.delete(`/api/microposts/${this.micropostId}`);
        this.$router.push('/microposts');
      }
    },
    async fetchComment() {
      const res = await axios.get(`/api/microposts/${this.micropostId}/comments`);
      this.comments = res.data.comments;
    },
    async upload() {
      let formData = new FormData();
      formData.append('content', this.content);
      await axios.post(`/api/microposts/${this.micropostId}/comments`, formData);
      this.resetForm();
      this.fetchComment();
    },
    resetForm() {
      this.content = '';
    }
  }
};
</script>