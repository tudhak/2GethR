import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="interactions"
export default class extends Controller {

  static values = {
    list: String,
    sound: String,
    };
  static targets = ["punch", "love", "kiss", "peace", "status"]


  connect() {
    console.log("hello from interactions controller");
  }

  dodo(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async playmood() {
    console.log("fire mood sound");
    console.log(this.soundValue);

    var audio = new Audio(this.soundValue)
    audio.play();

    await this.dodo(5000);

    console.log("stop sound");
    if (audio) {
      audio.pause();
      audio.currentTime = 0;
    }
  };


  async togglestatus() {
    console.log("fire togglestatus");
    this.statusTarget.classList.toggle("d-none");
  }

  async firepunch() {
    console.log("fire punch");
    // var audio = new Audio(this.soundValue)
    // audio.play();
    // await this.dodo(600);
    this.punchTarget.classList.toggle("displayed");
    await this.dodo(500);
    this.punchTarget.classList.toggle("displayed");
    };

  async firelove() {
    console.log("fire love");
    this.loveTarget.classList.toggle("displayed");
    await this.dodo(500);
    this.loveTarget.classList.toggle("displayed");
  }

  async firekiss() {
    console.log("fire kiss");
    this.kissTarget.classList.toggle("displayed");
    await this.dodo(500);
    this.kissTarget.classList.toggle("displayed");
  }

  async firepeace() {
    console.log("fire peace");
    this.peaceTarget.classList.toggle("displayed");
    await this.dodo(500);
    this.peaceTarget.classList.toggle("displayed");
  }

  async unleash() {
    let arraylist = this.listValue.split(";");
    arraylist.pop()
    console.log(arraylist);

    for (const element of arraylist) {
      console.log(element);
      switch (element) {
        case "kiss":
          this.firekiss();
          break;
        case "peace":
          this.firepeace();
          break;
        case "love":
          this.firelove();
        break;
        case "punch":
          this.firepunch();
        break;
      }
      await this.dodo(1000);
      //   this.inyourfaceTarget.innertext = element;
      // await new Promise(resolve => setTimeout(resolve, 1000));
      //   this.inyourfaceTarget.innerText = "";
    };

    location.reload();

  };

}
