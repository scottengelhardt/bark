<template>
  <div style="height:100vh">
    <div class="leftSide">
      <h1>Welcome to</h1>
      <div class="inputContainer">
        <div class="inputItem">
          <label for="first" class="lbl">First Name</label>
          <input 
            id="first"
            class="inputField" 
            type="text" 
            v-model="first" 
            placeholder="First Name"
          >
        </div>
        <div class="inputItem">
          <label for="last" class="lbl">Last Name</label>
          <input 
            id="last"
            class="inputField" 
            type="text" 
            v-model="last" 
            placeholder="Last Name"
          >
        </div>
        <div class="inputItem">
          <label for="email" class="lbl">Email Address</label>
          <input 
            id="email"
            class="inputField" 
            type="text" 
            v-model="email" 
            placeholder="Email Address"
          >
        </div>
        <div class="inputItem">
          <label for="password" class="lbl">Password</label>
          <!-- <span @click="reveal = !reveal" style="cursor: pointer">👁</span> -->
          <input 
            id="password"
            class="inputField" 
            style="margin-bottom:4px"
            :type="reveal ? 'text' : 'password'" 
            v-model="password" 
            placeholder="Password"
          >
          <div v-if="passWarning">
            <small class="warning">{{passWarning}}</small>
          </div>
          <!-- <input 
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
        </div>
        <div class="inputItem" style="flex-basis:100%; margin-top:20px">
          <button class="inputField submitBtn">Create Account</button>
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
    margin: 5px auto;
    margin-bottom: 15px;
    margin-top: 0;
    font-size: 1.2em !important;
    border: 2px solid rgba(0,0,0,0.5);
    padding: 5px 10px;
    border-radius: 10px;
    float: left;
  }
  .inputItem {
    flex-basis: 50%;
    flex-grow: 0;
  }
  .inputContainer {
    display: flex;
    margin-top: 3em;
    margin: 0.5em;
    flex-wrap: wrap;
    flex-direction: row;
    width: 100%;
  }
  .submitBtn {
    color: white;
    background: rgba(58, 96, 115, 1);
    width: 80%;
  }
  .leftSide {
    width: 70%;
    height: 100vh;
    background: linear-gradient(rgb(225, 242, 255) 0%, rgb(255, 255, 255) 77.69%);
    margin-right:0.5em;
  }
  .lbl {
    font-size: 1.3em;
    float: left;
    text-align: left;
    width:100%;
  }
  .warning {
    color: red;
  }
</style>
