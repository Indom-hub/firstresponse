import Router from "../router"
import Axios from "axios"

export default {
  namespaced: true,
  state: {
    maxCharacters: 5,
    characters: []
  },
  mutations: {
    SET_SETTINGS: (state, data) => {
      const configs = JSON.parse(data);
      state.maxCharacters = configs.maxCharacters
    },
    SET_CHARACTERS: (state, data) => {
      const chars = JSON.parse(data);
      state.characters = chars.characters;
    }
  },
  actions: {
    SelectCharacter(data) {
      Axios.post(`http://xrplife/charmanager_selectcharacter`, data);
    },
    DeleteCharacter(data) {
      Axios.post(`http://xrplife/charmanager_deletecharacter`, data);
    }
  }
}