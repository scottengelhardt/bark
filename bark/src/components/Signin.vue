<template>
  <div style="height:100vh">
    <div class="leftSide">
      <div class="inputContainer">
        <div class="inputItem">
          <span class="lbl">First Name</span>
          <input 
            class="inputField" 
            type="text" 
            v-model="first" 
            placeholder="First Name"
          >
        </div>
        <div class="inputItem">
          <span class="lbl">Last Name</span>
          <input 
            class="inputField" 
            type="text" 
            v-model="last" 
            placeholder="Last Name"
          >
        </div>
        <div class="inputItem">
          <span class="lbl">Email Address</span>
          <input 
            class="inputField" 
            type="text" 
            v-model="email" 
            placeholder="Email Address"
          >
        </div>
        <div class="inputItem">
          <span class="lbl">Password</span>
          <span @click="reveal = !reveal" style="cursor: pointer">👁</span>
          <input 
            class="inputField" 
            style="margin-bottom:4px"
            :type="reveal ? 'text' : 'password'" 
            v-model="password" 
            placeholder="Password"
          >
          <div v-if="passWarning">
            <small class="warning">{{passWarning}}</small>
          </div>
          <input 
            v-model="passLvl" 
            @input="generatePassword" 
            type="range" 
            min="0" 
            max="10" 
            value="0" 
            class="slider" 
            :style="accentColor"
            style="margin-bottom:12px"
          >
        </div>
        <div class="inputItem" style="flex-basis:100%; width:50%">
          <button class="inputField submitBtn" >Create Account</button>
        </div>
      </div>
    </div>
    <div style="width:40%">

    </div>
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
    accentColor(){
      let st = 'accent-color:'
      if (this.passLvl < 3){
        st += 'green'
      } else if(this.passLvl < 7){
        st += 'blue'
      } else {
        st += 'red'
      }
      return st
    },
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
    margin: 15px auto;
    margin-bottom: 15px;
    margin-top: 0;
    font-size: 1.5em !important;
    border: 2px solid rgba(0,0,0,0.5);
    padding: 5px 10px;
    border-radius: 10px;
    width: 80%;
  }
  .inputItem {
    flex-basis: 50%;
    flex-grow: 0;
  }
  .inputContainer {
    background:rgba(0, 0, 0, .2);
    border-radius: 15px 15px;
    box-shadow: 0 10px 20px rgba(0, 0, 0, .19), 0 6px 6px rgba(0, 0, 0, .23);
    display: flex;
    margin: 1em;
    flex-wrap: wrap;
    flex-direction: row;
    width: 100%;
  }
  .submitBtn {
    color: white;
    background: rgba(58, 96, 115, 1);
    width:40%;
  }
  .leftSide {
    width: 50%;
    height: 100vh;
    background: linear-gradient(rgb(225, 242, 255) 0%, rgb(255, 255, 255) 77.69%);
  }
  .lbl {
    color: white;
    font-weight: bold;
    font-size: 1.3em;
  }
  .warning {
    color: red;
  }
</style>


// scroll bar for generate password + password strength