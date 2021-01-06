<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <v-card>
        <v-card-title>
          <span class="headline">User Profile</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field label="Name" required v-model="user.name"></v-text-field>
              </v-col>
              <v-col cols="12">
                <v-textarea label="Introduction" v-model="user.introduction"></v-textarea>
              </v-col>
              <v-col cols="12">
                <template>
                  <v-container fluid>
                    <v-combobox
                            v-model="selectedTags"
                            :items="tags"
                            :search-input.sync="search"
                            hide-selected
                            hint="最大5つまで登録できます"
                            label="Add some tags"
                            multiple
                            persistent-hint
                            small-chips
                            :clearable="true"
                            :deletable-chips="true"
                    >
                      <template v-slot:no-data>
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
                </template>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="close">キャンセル</v-btn>
          <v-btn color="blue darken-1" text @click="updateProfile">更新</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
    import axios from 'axios'
    export default {
        data() {
            return {
                dialog: false,
                user: null,
                selectedTags: [],
                search: null,
                tags: []
            }
        },
        created() {
            this.user = { ...this.$store.getters['auth/currentUser']}
            this.selectedTags = this.user.tags.map((tag) => {
                return tag.name
            })
            this.fetchTags()
        },
        methods: {
            open() {
                this.dialog = true;
            },
            close() {
                this.dialog = false;
            },
            async updateProfile() {
                const userParams = {
                    user: {
                        name: this.user.name,
                        introduction: this.user.introduction,
                        tag_names: this.selectedTags
                    }
                }
                await this.$store.dispatch('auth/updateProfile', userParams)
                this.close()
            },
            async fetchTags() {
                const res = await axios.get(`/api/tags`)
                this.tags = res.data.tags.map((tag) => {
                    return tag.name
                })
            }
        },
        watch: {
            selectedTags (val) {
                if (val.length > 5) {
                    this.$nextTick(() => this.selectedTags.pop())
                }
            },
        },
    }
</script>