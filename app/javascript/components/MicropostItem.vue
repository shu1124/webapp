<template>
    <div>
        <v-list-item
          @click="$router.push(`/microposts/${micropost.id}`)"
        >
            <v-list-item-avatar>
                <v-img src="https://picsum.photos/80/80/?random"></v-img>
            </v-list-item-avatar>

            <v-list-item-content>
                <v-list-item-title v-html="micropost.user.name"></v-list-item-title>
                <v-list-item-subtitle style="white-space: pre-line" v-html="micropost.content"></v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action>
                <v-list-item-action-text v-text="$dayjs(micropost.created_at).format('YYYY-MM-DD HH:mm:ss')"></v-list-item-action-text>
            </v-list-item-action>
        </v-list-item>
        <v-divider
                :inset="true"
        ></v-divider>
    </div>

</template>
<script>
    export default {
        props: {
            micropost: {
                type: Object,
                required: true
            }
        }
    }
</script>