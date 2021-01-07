<template>
    <div >
        <v-textarea
                class= "ma-2"
                outlined
                color="indigo"
                name="input-7-2"
                label="コメント"
                v-model="micropostComment"
                prepend-icon="mdi-comment"
        ></v-textarea>
        <div class="text-center">
            <v-btn :dark="isValid" color="indigo" :disabled="!isValid" @click="createComment">コメント</v-btn>
        </div>
    </div>
</template>

<script>
    export default  {
        data() {
            return {
                micropostComment: ""
            }
        },
        computed: {
            isValid() {
                return this.micropostComment.length > 0 && this.micropostComment.length <= 140
            }
        },
        methods: {
            createComment() {
                this.$emit('created', this.micropostComment)
                this.micropostComment = ""
            }
        }
    }
</script>