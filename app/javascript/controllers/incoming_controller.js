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

    // Itération : pour chaque élément du tableau :
    // 1. Afficher la div : innerHtml dans la target
    // 2.Jouer le son associé
    // 3. Wait
    // 3.Fermer la div
    // 4.Repeat
    // 5.Recharger la page
    await this.dodo(600);
    location.reload();


    };

}
