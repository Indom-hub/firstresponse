import Vue from 'vue'
import Vuex from 'vuex'
import Axios from 'axios'

import nui from './modules/nui'
import chareditor from './modules/chareditor'
import charmanager from './modules/charmanager'

Vue.use(Vuex)

const Store = new Vuex.Store({
	state: {},
	mutations: {},
	actions: {},
	modules: {
		nui,
		chareditor,
		charmanager
	}
})

document.onreadystatechange = () => {
	if (document.readyState === "complete") {
		window.addEventListener("message", (event) => {
			const e = event.data
			let state = Store.state;
			if (state.nui.resource.debug) {
				console.log(`Message Type: ${e.type}`);
				console.log(`Message Data: ${JSON.stringify(e.data)}`);
			}
			Store.commit(`${e.type}`, e.data)
		});
		// Axios.post("http://xrplife/xrplife_nui_ready", {}).then((response) => { }).catch((error) => { }); // Wait until FirstResponse is `ready`
	}
}

export default Store;
