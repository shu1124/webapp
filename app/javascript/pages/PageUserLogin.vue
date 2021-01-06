<template>
    <div>
        <v-container>
            <v-row justify="center" align="center">
                <v-col
                        cols="12"
                        sm="8"
                        md="4">
                    <v-card class="elevation-12">
                        <v-card-text>

                            <v-form
                                    ref="form"
                                    lazy-validation
                            >
                                <v-text-field
                                        v-model="email"
                                        :rules="emailRules"
                                        label="E-mail"
                                        required
                                        prepend-icon="mdi-email"
                                ></v-text-field>

                                <v-text-field
                                        v-model="password"
                                        label="Password"
                                        required
                                        prepend-icon="mdi-lock"
                                        type="password"
                                ></v-text-field>
                            </v-form>
                        </v-card-text>

                        <v-card-actions>
                            <v-btn color="primary" @click="login">ログイン</v-btn>
                            <v-spacer></v-spacer>
                            <router-link to="/signup" class="text-decoration-none">ユーザー登録ページへ</router-link>
                        </v-card-actions>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<script>
    import axios from 'axios'
    export default {
        data: () => ({
            email: '',
            password: '',
        }),
        computed: {
            emailRules() {
                return [
                    v => !!v || 'E-mail is required',
                    v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
                ]
            },
        },
        methods: {
            async login() {
                if(this.$refs.form.validate()) {
                    try {
                        await axios.post(`/api/session`, {
                            session: {
                                email: this.email,
                                password: this.password
                            }
                        })
                        this.$router.push(`/`)
                    } catch(error) {
                        alert(error.response.data.error.messages)
                    }
                }
            }
        },
    }
</script>