import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clear-search"
export default class extends Controller {
    clear() {
  //     const input = this.element.closest(".input-group").querySelector(".input-search");
  //     if (input) {
  //       input.value = "";
  //       input.focus();
  //     }
  //   }
  // }
  document.getElementById('search-bar').addEventListener('input', function() {
    if (this.value.length > 0) {
      document.getElementById('clear-button').style.display = 'block';
    } else {
      document.getElementById('clear-button').style.display = 'none';
    })
  })
