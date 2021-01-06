<template>
    <v-container
            class="fill-height"
            fluid
    >
        <v-row justify="center" align="center">
            <v-col
                    cols="12"
                    sm="8"
                    md="6">
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
                                    :rules="passwordRules"
                                    label="Password"
                                    required
                                    prepend-icon="mdi-lock"
                                    type="password"
                            ></v-text-field>
                        </v-form>
                    </v-card-text>

                    <v-card-actions>
                        <router-link to="/signup" class="text-decoration-none caption">ユーザー登録ページへ</router-link>
                        <v-spacer></v-spacer>
                        <v-btn dark color="indigo" @click="login">ログイン</v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
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
            passwordRules() {
                return [
                    v => !!v || 'Password is required',
                ]
            },
        },
        methods: {
            async login() {
                if(this.$refs.form.validate()) {
                    try {
                        const sessionParams = {
                            session: {
                                email: this.email,
                                password: this.password
                            }
                        }
                        await this.$store.dispatch('auth/login', sessionParams)
                        this.$router.push(`/`)
                    } catch(error) {
                        alert(error.response.data.error.messages)
                    }
                }
            }
        },
    }
</script>