<template>
  <v-card>
    <v-card-title class="headline font-weight-regular blue-grey white--text">
      投稿する
    </v-card-title>
    <v-card-text>
      <v-subheader class="pa-0">
        Where do you live?
      </v-subheader>
      <v-file-input
        label="画像を添付"
        filled
        prepend-icon="mdi-camera"
        accept="image/png,image/jpeg"
        id="image" 
        name="image"
      ></v-file-input>
      <v-row>
        <v-col
          cols="12"
          sm="6"
        >
          <v-text-field
            label="タイトル"
            placeholder="タイトル"
            outlined
            prepend-icon="mdi-format-title"
            v-model="title"
          ></v-text-field>
        </v-col>

        <v-col
          cols="12"
          sm="6"
        >
          <v-text-field
            label="勉強した時間"
            placeholder="勉強した時間"
            outlined
            prepend-icon="mdi-clock-outline"
            v-model="time"
          ></v-text-field>
        </v-col>
      </v-row>
      <v-textarea
                outlined
                color="indigo"
                name="input-7-4"
                label="投稿"
                v-model="content"
                prepend-icon="mdi-comment"
      >
      </v-textarea>
      <v-card-actions pa-1>
      <v-spacer></v-spacer>
      <v-btn
        class="font-weight-regular blue-grey white--text"
        @click="upload"
      >
        投稿する
      </v-btn>
    </v-card-actions>
    </v-card-text>
  </v-card>
</template>

<script>
export default  {
    data() {
        return {
            content: "",
            title: "",
            time: "",
            imageFile: null
        }
    },
    computed: {
        isValid() {
            return this.micropostContent.length > 0 && this.micropostContent.length <= 140
        }
    },
    methods: {
      async upload() {
        let formData = new FormData();
        formData.append("content", this.content);
        formData.append("title", this.title);
        formData.append("time", this.time);
        if (this.imageFile !== null) {
          formData.append("image", this.imageFile);
        }
        await this.$store.dispatch("microposts/createPost", formData)
        this.resetForm();
      },
      resetForm() {
        this.content = "";
        this.title = "";
        this.time = "";
        this.imageFile = null;
      }
  }
}
</script>