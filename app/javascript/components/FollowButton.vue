<template>
  <div>
    <div v-if="isLiked" @click="deleteLike()">
      いいねを取り消す {{ count }}
    </div>
    <div v-else @click="registerLike()">
      いいねする {{ count }}
    </div>
  </div>
</template>

<script>
// axios と rails-ujsのメソッドインポート
import axios from 'axios';
import { csrfToken } from 'rails-ujs';
// CSRFトークンの取得とリクエストヘッダへの設定をしてくれます
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken();

export default {
  // propsでrailsのviewからデータを受け取る
  props: ['userId', 'postId'],
  data() {
    return {
    };
  },
  // 算出プロパティ ここではlikeListが変更される度に、count、isLiked が再構築される (watchで監視するようにしても良いかも)
  computed: {
    // いいね数を返す
    count() {
      return this.likeList.length;
    },
    // ログインユーザが既にいいねしているかを判定する
    isLiked() {
      if (this.likeList.length === 0) { return false; }
      return Boolean(this.findLikeId());
    }
  },
  // Vueインスタンスの作成・初期化直後に実行される
  created: function() {
    this.fetchLikeByPostId().then(result => {
      this.likeList = result;
    });
  },
  methods: {
    // rails側のindexアクションにリクエストするメソッド
    fetchLikeByPostId: async function() {
      const res = await axios.get(`/api/likes/?post_id=${this.postId}`);
      return res.data;
    },
    // rails側のcreateアクションにリクエストするメソッド
    registerLike: async function() {
      this.fetchLikeByPostId().then(result => {
        this.likeList = result;
      });
    },
    // rails側のdestroyアクションにリクエストするメソッド
    deleteLike: async function() {
    },
    // ログインユーザがいいねしているlikeモデルのidを返す
    findLikeId: function() {
      const like = this.likeList.find((like) => {
        return (like.user_id === this.userId);
      });
      if (like) { return like.id; }
    }
  }
};
</script>