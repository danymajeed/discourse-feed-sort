import { withPluginApi } from "discourse/lib/plugin-api";

function initializeDiscourseFeedSort(api) {

}

export default {
  name: "discourse-feed-sort",

  initialize() {
    withPluginApi("0.8.31", initializeDiscourseFeedSort);
  }
};
