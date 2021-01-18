<template>
  <div>
    {{ count }}
  </div>
</template>

<script>
import axios from 'axios';
import { csrfToken } from 'rails-ujs';
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken();

export default {
  // eslint-disable-next-line vue/require-prop-types
  props: ['userId'],
  data() {
    return {
      total: []
    };
  },
  computed: {
    count() {
      return this.total;
    }
  },
  created() {
    this.fetchTotaFollow().then(result =>{
      this.total = result.users.length;
    });
  },
  methods: {
    async fetchTotaFollow() {
      const res = await axios.get(`/api/users/${this.userId}/following/`);
      // eslint-disable-next-line no-undef
      if (res.status !== 200) { process.exit(); }
      return res.data;
    }
  }
};
</script>