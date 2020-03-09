<template>
  <v-layout row wrap>
    <span class="slider_text">{{ label }}</span>
    <v-slider
      :step="step"
      :min="min"
      :max="max"
      thumb-label="always"
      :thumb-size="18"
      v-bind:value="value"
      v-bind:input="UpdateBoundedValue"
      color="#636e72"
    ></v-slider>
  </v-layout>
</template>

<style>
  .slider_text {
    position: relative;
    font-size: 20px;
    color: white;
    left: 50%;
    text-align: center;
    transform: translateX(-50%);
    background-color: #636e72;
    padding: 10px;
    margin: 5px;
    width: 100%;
    border-radius: 5px;
    border-style: solid;
    border-color: white;
    border-width: 1px;
  }
</style>

<script>
export default {
  name: "EditorSlider",
  props: ["value", "label", "step", "min", "max"],
  methods: {
    UpdateBoundedValue(value) {
      this.$emit("input", value);
    }
  }
}
</script>