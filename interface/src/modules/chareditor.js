import Router from '../router'
export default {
  namespaced: true,
  state: {
    allowedModels: []
  },
  mutations: {
    SET_CHAREDITOR_SETTINGS: (state, data) => {
      state.allowedModels = JSON.parse(data.models);
    }
  },
  actions: {}
}