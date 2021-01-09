<template>
  <div>
    <avatar-upload
      v-model="show"
      field="img"
      :width="300"
      :height="300"
      lang-type="ja"
      img-format="png"
      @crop-success="cropSuccess"
      @crop-upload-success="cropUploadSuccess"
      @crop-upload-fail="cropUploadFail"
    />
  </div>
</template>

<script>
import AvatarUpload from 'vue-image-crop-upload';
export default {
  components: {
    AvatarUpload
  },
  data() {
    return {
      show: false,
    };
  },
  methods: {
    toggleShow() {
      this.show = !this.show;
    },
    // eslint-disable-next-line no-unused-vars
    async cropSuccess(imgDataUrl, field){
      console.log('-------- crop success --------');
      await this.$store.dispatch('auth/updateProfile', { user: { avatar: { data: imgDataUrl } } });
    },
    cropUploadSuccess(jsonData, field){
      console.log('-------- upload success --------');
      console.log(jsonData);
      console.log('field: ' + field);
    },
 
    cropUploadFail(status, field){
      console.log('-------- upload fail --------');
      console.log(status);
      console.log('field: ' + field);
    }
  }
};
</script>