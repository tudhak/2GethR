import { Controller } from "@hotwired/stimulus";
import { Chart } from "chart.js";
import * as Chartjs from "chart.js" ;

// Register all Chartjs controllers (dans le fichier Index dans l'exo 5 Stimulus)
const controllers = Object.values(Chartjs).filter(
  (chart) => chart.id !== undefined
) ;
Chart.register(...controllers) ;

// Connects to data-controller="chart"

export default class extends Controller {

  static targets = ["", "", ""]

  static values = {
    keystring: String,
    keynumber: Number,
    usermood: Object,
  }

  connect() {

    console.log("hello from partner mood chart")

    console.log(Object.keys(this.usermoodValue));
    const labels = Object.keys(this.usermoodValue);
    const data = Object.values(this.usermoodValue);
    console.log(labels);
    console.log(data);

    new Chart(
      this.element,
      {
        type: 'doughnut',
        data: {
          // labels: labels,
          datasets: [
            {
              label: 'Mood %',
              data,
              backgroundColor: [
                'rgb(32, 13, 92)',
                'rgb(128, 89, 255)',
                'rgb(93, 89, 96)',
                'rgb(226, 100, 108)',
              ],
              hoverOffset: 4
            }
          ]
        }
      }
    );
  }
}
