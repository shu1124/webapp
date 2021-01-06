<template>
    <v-container>
        <v-row>
            <v-col>
                <div class="pb-10">
                    <div class="mb-5" v-if="$store.getters['auth/currentUser']">
                        <micropost-form @created="createMicropost"></micropost-form>
                    </div>
                    <timeline-list v-if="isExistMicroposts" :microposts="microposts" class="mb-5"></timeline-list>
                    <div class="text-center" v-else>
                        一件もありません
                    </div>

                    <template v-if="pagingMeta">
                        <div class="text-center">
                            <v-pagination
                                    color="indigo"
                                    v-model="pagingMeta.current_page"
                                    :length="pagingMeta.total_pages"
                                    @input="paging"
                            ></v-pagination>
                        </div>
                    </template>
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>
<script>
    import MicropostForm from '@/components/MicropostForm'
    import TimelineList from '@/components/TimelineList'
    import axios from "axios";
    export default {
        data() {
            return {
                microposts: [],
                pagingMeta: null,
                currentPage: 1
            }
        },
        components: {
            MicropostForm,
            TimelineList
        },
        computed: {
            isExistMicroposts() {
                return this.microposts.length > 0
            }
        },
        created() {
            this.fetchMicroposts()
        },
        methods: {
            async fetchMicroposts() {
                const res = await axios.get(`/api/microposts`, { params: { page: this.currentPage } })
                this.microposts = res.data.microposts
                this.pagingMeta = res.data.meta
            },
            async createMicropost(micropostContent) {
                const micropostParams = {
                    micropost: {
                        content: micropostContent
                    }
                }
                const res = await axios.post(`/api/microposts`, micropostParams)
                this.microposts =[...[res.data.micropost], ...this.microposts]
            },
            paging(page) {
                this.currentPage = page
                this.fetchMicroposts()
                this.$vuetify.goTo(0)
            }
        }
    }
</script>