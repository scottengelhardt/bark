<template>
  <div style="height:100vh" class="bg" >
    <img class="ml-1 mt-1" src="../assets/s3.png" /> 
    <v-btn flat absolute style="right:10px;top:10px;color:red" href="/"><icon class="fa-solid fa-arrow-left"></icon>&nbsp;Sign out</v-btn> 
    <v-layout row wrap>
      <v-flex xs12 style="text-align:center">
        <h1 class="mt-5" style="font-size:5em">Thanks for Signing Up!</h1>
        <span class="smallHeader">Can I interest you in an interactive video?</span>
      </v-flex>
      <v-flex xs12 md6 offset-md3 class="mt-4">
        <div id='ms_frame_container' style='position: relative; overflow: hidden; padding-top: 56.25%;'>
          <iframe 
            id='ms_frame' 
            loading='lazy' 
            style='position: absolute;top: 0;left: 0; width: 100%; height: 100%; min-height:unset; min-width: unset; border: 0; max-height: 100vh;' 
            src='https://embed.mindstamp.com/e/LSCCmtjpOZmG' 
            allowFullscreen 
            allow='encrypted-media; microphone; camera; geolocation' 
            scrolling='no'>
          </iframe>
        </div>
      </v-flex>
      <v-flex xs12 style="text-align:center" class="mt-4">
        <v-btn large round color="#1942D8" class="interview" @click="startEmail">Schedule Interview</v-btn>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
export default {
  name: 'Welcome',
  data () {
    return {

    }
  }, 
  methods: {
    startEmail(){
      window.location.href = 'mailto:scott_engelhardt@outlook.com?subject=Bark Interview'
    }
  },
  computed: {
  },
  watch: {
  }
}
</script>

<style scoped>
  .smallHeader {
    font-size: 1.5em;
  }
  .interview {
    color: white;
    border: 1px white solid !important;
  }
  .bg {
    background: linear-gradient(rgb(225, 242, 255) 0%, rgb(255, 255, 255) 77.69%);
  }
</style>
