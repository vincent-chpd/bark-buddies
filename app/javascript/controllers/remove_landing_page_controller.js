import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-landing-page"
export default class extends Controller {
  static targets = ["landing", 'dashboard']

  connect() {
    // if (localStorage.getItem('landingHidden') === 'true') {
    //   this.landingTarget.classList.add("d-none");
    //   this.dashboardTarget.classList.remove("d-none");
    // }
  }
  remove() {
    this.landingTarget.classList.add("d-none");
    this.dashboardTarget.classList.remove("d-none");
    // localStorage.setItem('landingHidden', 'true');
  }

  // the commented code will make it so the landing page is hidden after the first visit
}
