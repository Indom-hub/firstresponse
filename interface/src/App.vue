<template>
	<v-app id="app" v-if="isVisible">
		<router-view/>
	</v-app>
</template>

<style>
#app {
	background-color: transparent !important;
	overflow-x: hidden !important;
	overflow-y: hidden !important;
}
</style>

<script>
import { mapState } from "vuex";

export default {
	name: "app",
	computed: {
		...mapState("nui", ["isVisible"])
	}
};
</script>