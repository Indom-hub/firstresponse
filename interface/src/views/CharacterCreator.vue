<template>
  <div>
    <div class="char_editor_header">
      <div class="header_button_create">
        <span class="header_button_text">FINISH!</span>
      </div>
      <div class="header_button_cancel">
        <span class="header_button_text">CANCEL</span>
      </div>
      <span class="header_text">CHARACTER CREATOR</span>
      <div v-for="(menu, key) in HeaderMenuButtons" :key="key" class="header_button" @click="SwitchSideMenu(menu)">
        <span class="header_button_text">{{menu}}</span>
      </div>
    </div>
    <div class="char_editor_side" v-bind:class="{side_menu_slide_in: ShowSideMenu, side_menu_slide_out: !ShowSideMenu}">
      <v-container grid-list-xs>
        <!--
          1. Character Name
          2. Character Gender
          3. Character Model ^ gender changes the models allowed to select
        -->
        <div v-if="SideMenu == 'info'"></div>
        <!--
          1. Mother / Father Selection
          2. Mix Ratio
        -->
        <div v-if="SideMenu == 'parents'"></div>
        <!--
          1. Head Shape
          2. Eye Mods
          3. Mouth Mods
          4. Nose Mods
        -->
        <div v-if="SideMenu == 'head'"></div>
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
    user-select: none;
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
    user-select: none;
  }
  .header_button:hover {
    background-color: #636e72;
  }

  .header_button_create {
    position: relative;
    background-color: #2d3436;
    height: 100%;
    width: 120px;
    right: 0px;
    float: right;
    user-select: none;
  }
  .header_button_create:hover {
    background-color: #2196F3;
  }

  .header_button_cancel {
    position: relative;
    background-color: #2d3436;
    height: 100%;
    width: 120px;
    right: 0px;
    float: right;
    user-select: none;
  }
  .header_button_cancel:hover {
    background-color: #F44336;
  }

  .header_button_text {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 16px;
    text-transform: uppercase;
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
      SideMenu: "info",
      HeaderMenuButtons: [
        "info",
        "parents",
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