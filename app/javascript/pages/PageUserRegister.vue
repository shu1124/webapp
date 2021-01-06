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
                                v-model="valid"
                                lazy-validation
                        >
                            <v-text-field
                                    v-model="name"
                                    :counter="10"
                                    :rules="nameRules"
                                    label="Name"
                                    required
                                    prepend-icon="mdi-account"
                            ></v-text-field>

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

                            <v-text-field
                                    v-model="passwordConfirmation"
                                    :rules="passwordConfirmationRules"
                                    label="PasswordConfirmation"
                                    required
                                    prepend-icon="mdi-lock"
                                    type="password"
                            ></v-text-field>

                        </v-form>
                    </v-card-text>

                    <v-card-actions>
                        <router-link to="/login" class="text-decoration-none caption">ログインページへ</router-link>
                        <v-spacer></v-spacer>
                        <v-btn dark color="indigo" @click="signup">新規登録</v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import axios from 'axios'
    export default {
        data: () => ({
            valid: true,
            name: '',
            email: '',
            password: '',
            passwordConfirmation: '',
        }),
        computed: {
            nameRules() {
                return [
                    v => !!v || 'Name is required',
                    v => (v && v.length <= 10) || 'Name must be less than 10 characters',
                ]
            },
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
            passwordConfirmationRules() {
                return [
                    v => !!v || 'PasswordConfirmation is required',
                    this.password === this.passwordConfirmation || 'Password must match'
                ]
            }
        },
        methods: {
            async signup() {
                if(this.$refs.form.validate()) {
                    try {
                        await axios.post(`/api/users`, {
                            user: {
                                name: this.name,
                                email: this.email,
                                password: this.password,
                                password_confirmation: this.passwordConfirmation
                            }
                        })
                        this.$router.push(`/login`)
                    } catch(err) {
                        alert(err.response.data.error.messages)
                    }
                }
            }
        },
    }
</script>