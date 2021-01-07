<template>
    <v-container>
        <v-row>
            <v-col>
                <div class="pb-10">
                    <div class="mb-5" v-if="$store.getters['auth/currentUser']">
                        <micropost-form @created="createMicropost"></micropost-form>
                    </div>
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>
<script>
    import MicropostForm from '@/components/MicropostForm'
    import axios from "axios";
    export default {
        components: {
            MicropostForm,
        },
        methods: {
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