<template>
  <div style="height:100vh">
    <v-layout row wrap style="text-align:center">
      <v-flex class="leftSide" xs12 sm6> 
        <img class="mt-5" src="../assets/s3.png" /> 
        <h1 class="mt-5">Join the Revolution</h1>
        <v-layout row wrap style="justify-content:center" class="ma-4">
          <v-flex xs10 md6>
            <label for="first" class="lbl">First Name</label>
            <v-text-field 
              id="first"
              class="inputField" 
              type="text" 
              v-model="first" 
              single-line
              outline
              placeholder="First Name"
            ></v-text-field>
          </v-flex>
          <v-flex xs10 md6>
            <label for="last" class="lbl">Last Name</label>
            <v-text-field 
              id="last"
              class="inputField" 
              type="text" 
              v-model="last" 
              single-line
              outline
              placeholder="Last Name"
            ></v-text-field>
          </v-flex>
          <v-flex xs10 md6>
            <label for="email" class="lbl">Email Address</label>
            <v-text-field 
              id="email"
              class="inputField" 
              type="text" 
              v-model="email" 
              single-line
              outline
              placeholder="Email Address"
            ></v-text-field>
          </v-flex>
          <v-flex xs10 md6>
            <label for="password" class="lbl">Password</label>
            <v-text-field 
              id="password"
              class="inputField" 
              :type="reveal ? 'text' : 'password'" 
              single-line
              outline
              :hint="passWarning"
              v-model="password" 
              placeholder="Password"
              :append-icon="!reveal ? 'fa-eye-slash' : 'fa-eye'"
              @click:append="reveal = !reveal"
            ></v-text-field>
            <!-- <v-text-field 
              v-model="passLvl" 
              @input="generatePassword" 
              type="range" 
              min="0" 
              max="10" 
              value="0" 
              class="slider" 
              :style="accentColor"
              style="margin-bottom:12px"
            > -->
          </v-flex>
          <v-flex xs12  style="text-align: -webkit-center">
            <v-btn round class="submitBtn" color="#1942D8">Create Account</v-btn>
          </v-flex>
        </v-layout>
      </v-flex>
      <v-flex xs12 sm6 class="rightSide">
        <div class="mt-5 ml-4">
          <h1 style="font-size:3.5em">Stop Barking Up The Wrong Tree</h1>
          <span class="mt-1 smallHeader">10X your engineering team with Scott</span>
          <div class="mt-5">
            <icon class="fa-solid fa-bolt icon" style="color:yellow"></icon>
            <span class="smallHeader">Lightning Fast Development</span>
          </div>
          <div class="mt-2">
            <icon class="fa-solid fa-bug-slash icon" style="color:red"></icon>
            <span class="smallHeader">Zero Bug Tolerance</span>
          </div>
          <div class="mt-2">
            <icon class="fa-solid fa-gem icon" style="color:white"></icon>
            <span class="smallHeader">Passion for Excellence </span>
          </div>
          <div class="mt-5" style="text-align:center">
             <v-carousel hide-controls hide-delimiters style="height:auto;text-align:center; box-shadow: none;" >
              <v-carousel-item
                v-for="(item,i) in fans"
                :key="i"
                fade
                height="200px"
              >
              <img :src="require(`../assets/${item}`)" style="max-width:100%; object-fit:contains" /></v-carousel-item>
            </v-carousel> 
          </div>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
export default {
  name: 'SignIn',
  data () {
    return {
      email: '',
      first: '',
      last: '',
      password: '',
      passLvl: 0,
      reveal: false,
      watchPass: true,
      fans: ['brett.png', 'tyler.png', 'zack.png'],
    }
  }, 
  methods: {
    generatePassword(){
      this.watchPass = false
      if (this.passLvl == 0){
        this.watchPass = true
        return
      }
      let lower = 'abcdefghijklmnopqrstuvwxyz'
      let upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      let numbers = '0123456789'
      let special = '~`!@#$%^&*()_+-={}[]:";\'<>?,./|\\'
      let all = lower.concat(upper, numbers, special)
      let lvl = 8 + this.passLvl * 2 - this.password.length
      for (var i = 0; i < lvl; i++){
        let num = Math.floor(Math.random() * all.length)
        this.password += all[num]
      }
      this.watchPass = true
    },
  },
  computed: {
    passWarning(){
      if (this.password.length === 0){
        return ""
      } else if (this.password.length < 8){
        return "Password must be 8+ characters"
      }
      if (this.password.toUpperCase() === this.password){
        return "Password must contain lower case letters"
      } else if (this.password.toLowerCase() === this.password){
        return "Password must contain upper case letters"
      } else if (!/\d/.test(this.password)){
        return "Password must contain numbers"
      } else if (!/[^\w\s]/.test(this.password)){
        return "Password must contain special characters"
      }
    },
    isValidEmail(){
			var re = /(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))/;
			return re.test(this.email)
		},
  },
  watch: {
    password(){
      if (this.watchPass){
        this.passLvl = Math.floor((this.password.length - 8) / 2)
      }
    }
  }
}
</script>

<style scoped>
  .inputField {
    margin: 5px auto;
    margin-bottom: 15px;
    font-size: 1.2em !important;
    border-radius: 10px;
    float: left;
    width:95%;
  }
  .submitBtn {
    color: white;
    background: #1942D8;
    border: 1px white solid !important;
  }
  .leftSide, .rightSide {
    height: 100vh;
    background: linear-gradient(rgb(225, 242, 255) 0%, rgb(255, 255, 255) 77.69%);
  }
  .rightSide {
    background: #1942D8;
    color: white; 
    text-align: left;
  }
  .lbl {
    font-size: 1.3em;
    float: left;
    text-align: left;
    width:100%;
  }
  .passWarning {
    color: red;
  }
  .smallHeader {
    font-size: 1.5em;
  }
  .icon {
    font-size:xx-large; 
    vertical-align: middle; 
  }
</style>
