<template>
  <v-card>
    <v-toolbar color="blue" dark flat class="display-1 justify-center font-weight-bold">
      <v-spacer/>
      {{ character_data.firstname }} {{ character_data.lastname }}
      <v-spacer/>
    </v-toolbar>
    <v-card-text>
      <div style="text-align: left;">Dob: {{ character_data.dob }}</div>
      <div style="text-align: left;">Creation Date: {{ character_data.created_at }}</div>
    </v-card-text>
    <v-card-actions>
      <v-btn color="red" dark block @click="DeleteCharacterStart">DELETE</v-btn>
      <v-btn color="success" dark block @click="SelectCharacter">SELECT</v-btn>
    </v-card-actions>
    <v-dialog
      v-model="showDeleteDialog"
      persistent :overlay="false"
      max-width="500px"
      transition="dialog-transition"
    >
    <v-card>
      <v-card-title primary-title>
        Are you sure?
      </v-card-title>
      <v-card-text>
        You are deleting the character {{ character_data.firstname }} {{ character_data.lastname }}. Once the character is deleted the ONLY way to get it back is to request it from staff.
      </v-card-text>
      <v-card-actions>
        <v-btn color="red" dark block @click="DeleteCharacter">DELETE</v-btn>
        <v-btn color="success" dark block @click="DeleteCharacterCancel">CANCEL</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
  </v-card>
</template>

<style>

</style>

<script>
export default {
  name: "character-card",
  props: ["character_data"],
  data() {
    return {
      showDeleteDialog: false
    }
  },
  methods: {
    SelectCharacter() {
      this.$store.dispatch("charmanager/SelectCharacter", {
        id: this.character_data.id
      });
    },
    DeleteCharacterStart() {
      this.showDeleteDialog = true;
    },
    DeleteCharacterCancel() {
      this.showDeleteDialog = false;
    },
    DeleteCharacter() {
      console.log(JSON.stringify(character_data));
      this.$store.dispatch("charmanager/DeleteCharacter", {
        id: this.character_data.id
      })
    }
  }
}


</script>