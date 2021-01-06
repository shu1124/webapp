<template>
    <v-container>
        <v-row>
            <v-col>
                <div v-if="micropost">
                    <v-list-item
                    >
                        <v-list-item-avatar @click="$router.push(`/users/${micropost.user.id}`)" style="cursor: pointer">
                            <v-img :src="micropost.user.avatar_url"></v-img>
                        </v-list-item-avatar>

                        <v-list-item-content>
                            <v-list-item-title v-html="micropost.user.name"></v-list-item-title>
                            <v-list-item-subtitle style="white-space: pre-line" v-html="micropost.content"></v-list-item-subtitle>
                        </v-list-item-content>
                        <v-list-item-action>
                            <v-list-item-action-text v-text="$dayjs(micropost.created_at).format('YYYY-MM-DD HH:mm:ss')"></v-list-item-action-text>
                            <div v-if="isMine" class="d-flex">
                                <v-btn fab small dark color="teal" @click="openEditMicropost" class="mx-2">
                                    <v-icon>mdi-pen</v-icon>
                                </v-btn>
                                <v-btn fab small dark color="error" @click="deleteMicropost" class="mx-2">
                                    <v-icon>mdi-delete</v-icon>
                                </v-btn>
                            </div>
                        </v-list-item-action>
                    </v-list-item>
                    <v-divider
                            :inset="true"
                    ></v-divider>
                    <micropost-edit-modal v-if="isMine" ref="dialog" :micropost="micropost" @update="updateMicropost"></micropost-edit-modal>
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import axios from 'axios'
    import MicropostEditModal from '@/components/MicropostEditModal'
    export default {
        data() {
            return {
                micropost: null,
            }
        },
        components: {
            MicropostEditModal
        },
        created() {
            this.fetchMicropost()
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
            }
        }
    }
</script>