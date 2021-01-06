<template>
    <v-container>
        <v-row>
            <v-col>
                <div>
                    <div class="mb-5" v-if="$store.getters['auth/currentUser']">
                        <micropost-form @created="createMicropost"></micropost-form>
                    </div>
                    <timeline-list v-if="isExistMicroposts" :microposts="microposts"></timeline-list>
                    <div class="text-center" v-else>
                        一件もありません
                    </div>
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
                const res = await axios.get(`/api/microposts`)
                this.microposts = res.data.microposts
            },
            async createMicropost(micropostContent) {
                const micropostParams = {
                    micropost: {
                        content: micropostContent
                    }
                }
                const res = await axios.post(`/api/microposts`, micropostParams)
                this.microposts =[...[res.data.micropost], ...this.microposts]
            }
        }
    }
</script>