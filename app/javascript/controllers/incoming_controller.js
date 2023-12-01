import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="actions-received"
export default class extends Controller {
  connect() {
    console.log("hello handsome, my name is Kim")
  }

  static values = {list: String};
  static targets = ["inyourface"];

  dodo(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async unleash() {
    console.log("incomiiiinnng!!!");
    let arraylist = this.listValue.split(";");
    arraylist.pop()
    console.log(arraylist);

    // arraylist.forEach(function(element) {
    //   // Code à exécuter pour chaque élément
    //   console.log(element);
    //   this.inyourfaceTarget.innertext = element;
    //   await this.dodo(250);
    //   this.inyourfaceTarget.innerText = "";
    // });

    await this.dodo(2000);
    location.reload();


    };

}
