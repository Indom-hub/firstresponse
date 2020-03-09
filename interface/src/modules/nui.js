import Router from '../router'
export default {
	namespaced: true,
	state: {
		isVisible: true,
		resource: {
			name: null,
			debug: true
		},
		currentPage: "/"
	},
	mutations: {
		SET_VISIBLE: (state, data) => {
			state.isVisible = data.visible;
			if (state.resource.debug) {
				console.log(`Current Visibility State: ${state.isVisible}`);
			}
		},
		SET_RESOURCE_SETTINGS: (state, data) => {
			state.resource.name = data.name;
			state.resource.debug = data.debug;
			if (state.resource.debug) {
				console.log(`Current Application Name: ${state.resource.name}`);
				console.log(`Current Debug Mode: ${state.resource.debug}`);
			}
		},
		CHANGE_PAGE: (state, data) => {
			state.currentPage = data.page;
			Router.push(state.currentPage);
		}
	}
}