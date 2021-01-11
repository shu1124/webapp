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
          <v-row>
            <v-col
              cols="12"
              sm="6"
            >
              <v-text-field
                v-model="micropostTitle"
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
                v-model="micropostTime"
                label="勉強した時間"
                placeholder="勉強した時間"
                outlined
                prepend-icon="mdi-clock-outline"
              />
            </v-col>
          </v-row>
          <v-textarea
            v-model="micropostContent"
            outlined
            color="indigo"
            name="input-7-4"
            label="投稿"
            prepend-icon="mdi-comment"
          />
          <v-col cols="12">
            <v-container fluid>
              <v-combobox
                v-model="selectedGenres"
                :items="genres"
                :search-input.sync="search"
                hide-selected
                hint="最大5つまで登録できます"
                label="Add some genres"
                multiple
                persistent-hint
                small-chips
                :clearable="true"
                :deletable-chips="true"
              >
                <template 
                  #no-data
                >
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>
                        タグ"<strong>{{ search }}</strong>"はまだ登録されていません。<kbd>enter</kbd>で登録できます。
                      </v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                </template>
              </v-combobox>
            </v-container>
          </v-col>
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
              @click="update"
            >
              更新
            </v-btn>
          </v-card-actions>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import axios from 'axios';
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
      selectedGenres: [],
      search: null,
      genres: []
    };
  },
  computed: {
    isValid() {
      return this.micropostContent.length > 0 && this.micropostContent.length <= 1000;
    }
  },
  watch: {
    selectedGenres (val) {
      if (val.length > 5) {
        this.$nextTick(() => this.selectedGenres.pop());
      }
    },
  },
  created() {
    this.micropostContent = this.micropost.content;
    this.micropostTitle = this.micropost.title;
    this.micropostTime = this.micropost.time;
    this.selectedGenres = this.micropost.genres.map((genre) => {
      return genre.name;
    });
    this.fetchGenres();
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
    async update() {
      const micropostParams = {
        micropost: {
          content: this.micropostContent,
          title: this.micropostTitle,
          time: this.micropostTime,
          genre_names: this.selectedGenres
        }
      };
      this.$emit('update', micropostParams);
    },
    // async update() {
    //   const genre_names = this.selectedGenres
    //   let formData = new FormData();
    //   formData.append("content", this.micropostContent);
    //   formData.append("title", this.micropostTitle);
    //   formData.append("time", this.micropostTime);
    //   formData.append("genre_names", this.genre_names);
    //     if (this.imageFile !== null) {
    //       formData.append("image", this.imageFile);
    //     }
    //   this.$emit('update', formData)
    // },
    //  async updateProfile() {
    //     const userParams = {
    //         user: {
    //             name: this.user.name,
    //             introduction: this.user.introduction,
    //             tag_names: this.selectedTags
    //         }
    //     }
    //     await this.$store.dispatch('auth/updateProfile', userParams)
    //     this.close()
    // },
    async fetchGenres() {
      const res = await axios.get('/api/genres');
      this.genres = res.data.genres.map((genre) => {
        return genre.name;
      });
    }
  },
};
</script>