<template>
  <v-container bg fill-height grid-list-md text-xs-center>
    <v-layout row wrap align-center>
      <v-flex>
        <v-card>
          <v-toolbar color="#2d3436" dark flat class="display-1 justify-center font-weight-bold">
            <v-spacer/>
              CHARACTERS
            <v-spacer/>
          </v-toolbar>
          <v-card-text>
            <v-container grid-list-xs>
              <v-layout row wrap justify-center>
                <v-flex xs12 md6 lg4 v-for="(char, charIndex) in characters" :key="charIndex">
                  <character-card :character_data="char"></character-card>
                </v-flex>
                <!-- New Character Card -->
                <v-flex xs12 md6 lg4 v-if="characters.length < maxCharacters">
                  <v-card height="100%">
                    <v-toolbar color="#2d3436" dark flat class="display-1 justify-center font-weight-bold">
                      <v-spacer/>
                        NEW CHARACTER
                      <v-spacer/>
                    </v-toolbar>
                    <v-card-actions>
                      <v-btn color="blue" dark block>CREATE</v-btn>
                    </v-card-actions>
                  </v-card>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<style>

</style>

<script>
import { mapState, mapActions } from "vuex";
import CharacterCard from "@/components/CharacterCard"

export default {
  data() {
    return {
      showNewDialog: false
    }
  },
  computed: {
    ...mapState("charmanager", [ "maxCharacters", "characters" ]),
    ...mapActions("charmanager", [ "SelectCharacter" ])
  },
  methods: {
    CreateNewCharacterStart() {
      showNewDialog = true;
    },
    CreateNewCharacterCancel() {
      showNewDialog = false
    },
    CreateNewCharacter() {
      // Route UI to change to character creator UI
    }
  },
  components: {
    CharacterCard
  }
}
</script>