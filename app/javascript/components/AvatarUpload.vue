<template>
  <div>
    <avatar-upload field="img"
                   @crop-success="cropSuccess"
                   @crop-upload-success="cropUploadSuccess"
                   @crop-upload-fail="cropUploadFail"
                   v-model="show"
                   :width="300"
                   :height="300"
                   langType="ja"
                   img-format="png"></avatar-upload>
  </div>
</template>

<script>
  import AvatarUpload from 'vue-image-crop-upload';
  export default {
      data() {
          return {
              show: false,
          }
      },
      components: {
          AvatarUpload
      },
      methods: {
          toggleShow() {
              this.show = !this.show;
          },
          /**
           * crop success
           *
           * [param] imgDataUrl
           * [param] field
           */
          async cropSuccess(imgDataUrl, field){
              console.log('-------- crop success --------');
              await this.$store.dispatch('auth/updateProfile', { user: { avatar: { data: imgDataUrl } } })
          },
          /**
           * upload success
           *
           * [param] jsonData  server api return data, already json encode
           * [param] field
           */
          cropUploadSuccess(jsonData, field){
              console.log('-------- upload success --------');
              console.log(jsonData);
              console.log('field: ' + field);
          },
          /**
           * upload fail
           *
           * [param] status    server api return error status, like 500
           * [param] field
           */
          cropUploadFail(status, field){
              console.log('-------- upload fail --------');
              console.log(status);
              console.log('field: ' + field);
          }
      }
  }
</script>