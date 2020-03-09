<template>
  <div>
    <div class="char_editor_header">
      <span class="header_text">CHARACTER EDITOR</span>
      <div v-for="(menu, key) in HeaderMenuButtons" :key="key" class="header_button" @click="SwitchSideMenu(menu)">
        <span class="header_button_text">{{menu}}</span>
      </div>
    </div>
    <div class="char_editor_side" v-bind:class="{side_menu_slide_in: ShowSideMenu, side_menu_slide_out: !ShowSideMenu}">
      <v-container grid-list-xs>
        <div v-if="SideMenu == 'face'">
          <EditorSlider v-model="TestingModel" label="Testing" step="0.1" min="-1" max="1" />
        </div>
      </v-container>
    </div>
  </div>
</template>

<style>
  .char_editor_header {
    position: relative;
    width: 100%;
    height: 75px;
    background-color: #2d3436;
    color: white;
  }

  .header_text {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    position: absolute;
    font-size: 30px;
    top: 50%;
    left: 10px;
    transform: translateY(-50%);
  }

  .char_editor_side {
    position: absolute;
    width: 350px;
    height: calc(100% - 75px);
    right: 0px;
    top: 75px;
    background-color: #2d3436;
    padding: 10px;
    overflow: auto;
  }

  .header_button {
    position: relative;
    background-color: #2d3436;
    height: 100%;
    width: 120px;
    right: 0px;
    float: right;
  }

  .header_button_text {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    font-weight: bold;
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    text-transform: uppercase;
  }

  .header_button:hover {
    background-color: #636e72;
  }

  .side_menu_slide_in {
    animation-name: SideMenuSlideIn;
    animation-duration: 0.5s;
    animation-fill-mode: forwards;
  }

  .side_menu_slide_out {
    animation-name: SideMenuSlideOut;
    animation-duration: 0.5s;
    animation-fill-mode: forwards;
  }

  /* ANIMATIONS */
  @keyframes SideMenuSlideOut {
    from {
      right: 0px;
    }
    to {
      right: -350px;
    }
  }
  @keyframes SideMenuSlideIn {
    from {
      right: -350px;
    }
    to {
      right: 0px;
    }
  }
</style>

<script>
import EditorSlider from "@/components/EditorSlider.vue";
import { mapState } from "vuex";

export default {
  data() {
    return {
      ShowSideMenu: true,
      SideMenuAnimating: false,
      SideMenu: "face",
      HeaderMenuButtons: [
        "face",
        "head"
      ].reverse(),
      TestingModel: "0"
    }
  },
  computed: {
    ...mapState("chareditor", ["allowedModels"])
  },
  methods: {
    SwitchSideMenu(menu) {
      if (this.SideMenuAnimating) return;
      if (menu == this.SideMenu) return;
      this.SideMenuAnimating = true;
      this.ShowSideMenu = false;
      setTimeout(() => {
        this.SideMenu = menu;
        this.ShowSideMenu = true;
        setTimeout(() => {
          this.SideMenuAnimating = false;
        }, 650);
      }, 650);
    }
  },
  components: {EditorSlider}
}
</script>