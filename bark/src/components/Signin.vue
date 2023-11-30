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
              :hint="fnWarn"
              persistent-hint
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
              :hint="lnWarn"
              persistent-hint
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
              :hint="emWarn"
              persistent-hint
              placeholder="Email Address"
            ></v-text-field>
          </v-flex>
          <v-flex xs10 md6>
            <label for="password" class="lbl">
              Password
              <span style="float:right" class="mr-3">
                <icon 
                class="fa-solid fa-gear" 
                style="color: grey; cursor: pointer"
                @click="generatePassword"
              ></icon></span>
            </label>
            <v-text-field 
              id="password"
              class="inputField" 
              :type="reveal ? 'text' : 'password'" 
              single-line
              outline
              :hint="psWarn"
              persistent-hint
              v-model="password" 
              placeholder="Password"
              :append-icon="!reveal ? 'fa-eye-slash' : 'fa-eye'"
              @click:append="reveal = !reveal"
            ></v-text-field>
          </v-flex>
          <v-flex xs12  style="text-align: -webkit-center">
            <v-btn large round class="submitBtn" color="#1942D8" @click="submit">Create Account</v-btn>
            <div v-if="submitError" style="color:red" class="smallHeader mt-3">
              {{submitError}}
            </div>
          </v-flex>
        </v-layout>
      </v-flex>
      <v-flex xs12 sm6 class="rightSide">
        <div class="mt-5 ml-5">
          <h1 style="font-size:3.5em">Stop Barking Up The Wrong Tree</h1>
          <span class="mt-1 smallHeader">10X your engineering team with Scott</span>
          <div class="mt-5">
            <icon class="fa-solid fa-bolt icon" style="color:yellow"></icon>
            <span class="smallHeader">Lightning Fast Development</span>
          </div>
          <div class="mt-3">
            <icon class="fa-solid fa-bug-slash icon" style="color:red"></icon>
            <span class="smallHeader">Zero Bug Tolerance</span>
          </div>
          <div class="mt-3 mb-5">
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
import axios from 'axios'
export default {
  name: 'SignIn',
  data () {
    return {
      email: '',
      first: '',
      last: '',
      password: '',
      reveal: false,
      fans: ['brett.png', 'tyler.png', 'zack.png'],
      fnWarn: '',
      lnWarn: '',
      emWarn: '',
      hasSubmit: false,
      submitError: false,
    }
  }, 
  methods: {
    generatePassword(){
      this.password = ''
      this.reveal = true
      let lower = 'abcdefghijklmnopqrstuvwxyz'
      let upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      let numbers = '0123456789'
      let special = '~`!@#$%^&*()_+-={}[]:";\'<>?,./|\\'
      let all = lower.concat(upper, numbers, special)
      for (var i = 0; i < 20; i++){
        let num = Math.floor(Math.random() * all.length)
        this.password += all[num]
      }
      if (this.needLower){
        this.password += lower[Math.floor(Math.random() * lower.length)]
      }
      if (this.needUpper){
        this.password += upper[Math.floor(Math.random() * upper.length)]
      }
      if (this.needNumber){
        this.password += numbers[Math.floor(Math.random() * numbers.length)]
      }
      if (this.needSpecial){
        this.password += special[Math.floor(Math.random() * special.length)]
      }
      setTimeout(() => {
        this.reveal = false
      },200) 
    },
    submit(){
      this.hasSubmit = true
      let hasErr = false
      if (!this.first){
        hasErr = true
        this.fnWarn = 'First Name Required'
      }
      if (!this.last){
        hasErr = true
        this.lnWarn = 'Last Name Required'
      }
      if (!this.isValidEmail){
        hasErr = true
        this.emWarn = 'Invalid Email'
      }
      if (this.psWarn){
        hasErr = true
      }
      if(hasErr){
        return
      }
      axios.post('http://localhost:3000/user', {
        user: {
          first: this.first,
          last: this.last,
          email: this.email,
          password: this.password,
        }
      })
      .then(function (response) {
        window.location.href = '/welcome'
      })
      .catch((error) => {
        this.submitError = error.response.data.error
      });
    }
  },
  computed: {
    needLower(){
      return this.password ? this.password.toUpperCase() === this.password: false
    },
    needUpper(){
      return this.password ? this.password.toLowerCase() === this.password : false
    },
    needNumber(){
      return this.password ? !/\d/.test(this.password) : false
    },
    needSpecial(){
      return this.password ? !/[^\w\s]/.test(this.password) : false
    },
    psWarn(){
      if (this.password.length === 0 && this.hasSubmit){
        return 'Password Required'
      } else if (this.password.length === 0 && !this.hasSubmit){
        return ''
      } else if (this.password.length < 8){
        return "Password must be 8+ characters"
      }
      if (this.needLower){
        return "Password must contain lower case letters"
      } else if (this.needUpper){
        return "Password must contain upper case letters"
      } else if (this.needNumber){
        return "Password must contain numbers"
      } else if (this.needSpecial){
        return "Password must contain special characters"
      }
    },
    isValidEmail(){
			var re = /(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))/;
			return re.test(this.email)
		},
  },
  watch: {
    first(){
      this.fnWarn = ''
    },
    last(){
      this.lnWarn = ''
    },
    email(){
      this.emWarn = ''
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
  .v-tooltip__content {
  font-size: 50px !important;
  opacity: 1 !important;
  display: block !important;
}
</style>
