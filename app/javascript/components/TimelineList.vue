<template>
    <v-card>
        <v-list three-line>
            <micropost-item v-for="micropost in microposts" :key="micropost.id" :micropost="micropost"></micropost-item>
        </v-list>
    </v-card>
</template>

<script>
    import MicropostItem from '@/components/MicropostItem'
    export default {
        props: {
            microposts: {
                type: Array,
                default: []
            }
        },
        components: {
            MicropostItem
        }
    }
</script> 