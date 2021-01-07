<template>
    <v-container>
        <v-row>
            <v-col>
                <div class="pb-10">
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
            paging(page) {
                this.currentPage = page
                this.fetchMicroposts()
                this.$vuetify.goTo(0)
            }
        }
    }
</script>