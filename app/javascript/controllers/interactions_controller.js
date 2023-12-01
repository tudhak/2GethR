import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="interactions"
export default class extends Controller {

  static values = { sound: String }

  connect() {
    console.log(this.soundValue)
  }

  static targets = ["punch", "love", "kiss", "peace"]

  dodo(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async firepunch() {
    console.log("fire punch");
    var audio = new Audio(this.soundValue)
    audio.play();
    await this.dodo(600);
    this.punchTarget.classList.remove("d-none");
    await this.dodo(250);
    this.punchTarget.classList.add("d-none");
    };

  async firelove() {
    console.log("fire love");
    this.loveTarget.classList.remove("d-none");
    await this.dodo(250);
    this.loveTarget.classList.add("d-none");
  }

  async firekiss() {
    console.log("fire kiss");
    this.kissTarget.classList.remove("d-none");
    await this.dodo(250);
    this.kissTarget.classList.add("d-none");
  }

  async firepeace() {
    console.log("fire peace");
    this.peaceTarget.classList.remove("d-none");
    await this.dodo(250);
    this.peaceTarget.classList.add("d-none");
  }
}
