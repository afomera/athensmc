/* eslint no-console:0 */

require("@rails/ujs").start();

import "@hotwired/turbo-rails";

import "bootstrap";

import RconConsole from "../servers/RconConsole";

class Dispatcher {
  constructor() {
    this.pageName = document.body.dataset.page;
  }

  route() {
    switch (this.pageName) {
      case "admin:servers:show":
        new RconConsole().init();
        break;
    }
  }
}

document.addEventListener("turbo:load", () => {
  const dispatcher = new Dispatcher();

  dispatcher.route();
  // $('[data-toggle="tooltip"]').tooltip();
  // $('[data-toggle="popover"]').popover();
});
