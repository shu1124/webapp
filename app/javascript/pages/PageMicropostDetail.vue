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
      <v-row class="fill-height">
        <v-spacer></v-spacer>

        <v-card-title class="white--text pl-12 pt-12">
          <div class="display-1 pl-12 pt-12">
            {{ micropost.title }}
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

      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="indigo">
            mdi-format-title
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-subtitle>タイトル</v-list-item-subtitle>
          <v-list-item-title>{{micropost.title}}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="indigo">
            mdi-clock-outline
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-subtitle>勉強時間</v-list-item-subtitle>
          <v-list-item-title>{{micropost.time}}h</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="indigo">
            mdi-comment
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-subtitle>本文</v-list-item-subtitle>
          {{micropost.content}}
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
  <v-divider></v-divider>
    <v-list three-line v-for="comment in comments" :key="comment.id">
        <v-list-item>
          <v-list-item-avatar>
            <v-img :src="comment.user.avatar_url"></v-img>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-subtitle v-text="$dayjs(micropost.created_at).format('YYYY-MM-DD HH:mm:ss')"></v-list-item-subtitle>
            <v-list-item-title >{{comment.content}}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-divider></v-divider>
    </v-list>
    <v-textarea
        class= "ma-2"
        outlined
        color="indigo"
        name="input-7-2"
        label="コメント"
        v-model="content"
        prepend-icon="mdi-comment"
    ></v-textarea>
    <div class="text-center">
      <v-btn class= "ma-1" depressed color="primary" @click="upload">コメント</v-btn>
    </div>
  </v-card>
  </v-col>
</v-row>
</template>

<script>
import axios from 'axios'
import MicropostEditModal from '@/components/MicropostEditModal'
import CommentForm from '@/components/CommentForm'
export default {
    data() {
        return {
            micropost: null,
            comments: [],
            content: ""
        }
    },
    components: {
        MicropostEditModal,
        CommentForm

    },
    created() {
        this.fetchMicropost(),
        this.fetchComment()
    },
    computed: {
        micropostId() {
            return this.$route.params.id
        },
        isMine() {
            if(!this.$store.getters['auth/currentUser']) return false
            return this.micropost.user.id == this.$store.getters['auth/currentUser'].id
        }
    },
    methods: {
        async fetchMicropost() {
            const res = await axios.get(`/api/microposts/${this.micropostId}`)
            this.micropost = res.data.micropost
        },
        openEditMicropost() {
            this.$refs.dialog.open()
        },
        async updateMicropost(micropostContent) {
            await axios.patch(`/api/microposts/${this.micropostId}`, { micropost: { content: micropostContent } })
            this.$refs.dialog.close()
            this.micropost.content = micropostContent
        },
        async deleteMicropost() {
            if(confirm("削除しますか？")) {
                await axios.delete(`/api/microposts/${this.micropostId}`)
                this.$router.push(`/microposts`)
            }
        },
        async fetchComment() {
            const res = await axios.get(`/api/microposts/${this.micropostId}/comments`)
            this.comments = res.data.comments
        },
        async createComment(micropostComment) {
            const commentParams = {
                comment: {
                    content: micropostComment
                }
            }
            const res = await axios.post(`/api/microposts/${this.micropostId}/comments`, commentParams)
            this.comments =[...[res.data.comment], ...this.comments]
        },
        async upload() {
          let formData = new FormData();
          formData.append("content", this.content);
          await axios.post(`/api/microposts/${this.micropostId}/comments`, formData)
          this.resetForm();
        },
        resetForm() {
          this.content = "";
        }
    }
}
</script>