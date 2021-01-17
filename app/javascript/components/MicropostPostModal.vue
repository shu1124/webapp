<template>
  <v-row justify="center">
    <v-dialog 
      v-model="dialog"
      max-width="600px"
    >
      <v-card>
        <v-card-title class="headline font-weight-regular blue-grey white--text">
          投稿する
        </v-card-title>
        <v-card-text>
          <v-subheader class="pa-0">
            勉強内容をアウトプットしましょう
          </v-subheader>
          <v-file-input
            id="image"
            label="image"
            filled
            prepend-icon="mdi-camera"
            accept="image/png,image/jpeg" 
            name="image"
            type="file"
            @change="setImage"
          />
          <v-row>
            <v-col
              cols="12"
              sm="6"
            >
              <v-text-field
                v-model="title"
                :rules="titleRules"
                label="タイトル"
                placeholder="タイトル"
                outlined
                prepend-icon="mdi-format-title"
              />
            </v-col>
            <v-col
              cols="12"
              sm="6"
            >
              <v-text-field
                v-model="time"
                :rules="timeRules"
                label="勉強した時間"
                placeholder="勉強した時間"
                outlined
                prepend-icon="mdi-clock-outline"
              />
            </v-col>
          </v-row>
          <v-textarea
            v-model="content"
            :rules="contentRules"
            outlined
            color="indigo"
            name="input-7-4"
            label="投稿"
            prepend-icon="mdi-comment"
          />
          <v-card-actions>
            <v-spacer />
            <v-btn 
              color="indigo" 
              text 
              @click="close"
            >
              キャンセル
            </v-btn>
            <v-btn 
              :dark="isValid" 
              color="indigo" 
              :disabled="!isValid" 
              @click="upload"
            >
              投稿する
            </v-btn>
          </v-card-actions>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  props: {
    micropost: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      dialog: false,
      content: '',
      title: '',
      time: '',
      imageFile: null,
      titleRules: [
        v => !!v || 'Title is required',
        v => (v && v.length <= 30) || 'Title must be less than 30 characters',
      ],
      timeRules: [
        v => !!v || 'Time is required',
        v => /[0-9]+/.test(v) || 'Time must be valid',
      ],
      contentRules: [
        v => !!v || 'Content is required',
        v => (v && v.length <= 30) || 'Time must be valid',
      ],
    };
  },
  computed: {
    isValid() {
      return this.content.length > 0 && this.time.length > 0 && this.title.length > 0;
    }
  },
  methods: {
    setImage(e) {
      this.imageFile = e;
    },
    open() {
      this.dialog = true;
    },
    close() {
      this.dialog = false;
    },
    async upload() {
      let formData = new FormData();
      formData.append('content', this.content);
      formData.append('title', this.title);
      formData.append('time', this.time);
      if (this.imageFile !== null) {
        formData.append('image', this.imageFile);
      }
      this.$emit('upload', formData);
      this.close();
      this.resetForm();
    },
    resetForm() {
      this.content = '';
      this.title = '';
      this.time = '';
      this.image = '';
      this.imageFile = null;
    }
  }
};
</script>