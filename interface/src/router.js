import Vue from 'vue'
import Vuetify from 'vuetify'
import Router from 'vue-router'
import Axios from 'axios'
import VueAxios from "vue-axios"

// Views
import CharacterManager from './views/CharacterManager.vue'
import CharacterCreator from './views/CharacterCreator.vue'

// Vuetify Extras
import 'material-design-icons-iconfont/dist/material-design-icons.css' // Load above vuetify.min.css to avoid styling issues
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)
Vue.use(Router)
Vue.use(VueAxios, Axios)

export default new Router({
	routes: [
		{
			path: "/charmanager",
			name: "charmanager",
			component: CharacterManager
		},
		{
			path: "/charcreator",
			name: "charcreator",
			component: CharacterCreator
		}
	]
})