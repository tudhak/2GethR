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
  }

  connect() {

    console.log("hello from tasks chart")

    // const labels = Object.keys(this.worldPopulation);
    // const data = Object.values(this.worldPopulation);
    // console.log(labels);
    // console.log(data);

    new Chart(
      this.element,
      {
        type: 'radar',
        data: {
          labels: ["dishwashing", "laundry", "cleaning", "cooking", "ironing", "shopping", "dog", "kids", "other",],
          datasets: [
            {
              label: 'I am a legend',
              data: [0.3, 0.7, 0.4, 0.6, 0.3, 0.7, 0.4, 0.6, 0.4],
              fill: true,
              backgroungColor: 'rgb(255, 99, 132, 0.2)',
              borderColor: 'rgb(255, 99, 132)',
              pointBackgroundColor: 'rgb(255, 99, 132)',
              pointBorderColor: '#fff',
              pointHoverBackgroundColor: '#fff',
              pointHoverBorderColor: 'rgb(255, 99, 132)'
            }, {
              label: 'I am a legend',
              data: [0.7, 0.3, 0.6, 0.4,0.7, 0.4, 0.6, 0.4, 0.6 ],
              fill: true,
              backgroungColor: 'rgb(255, 99, 132, 0.2)',
              borderColor: 'rgb(255, 99, 132)',
              pointBackgroundColor: 'rgb(255, 99, 132)',
              pointBorderColor: '#fff',
              pointHoverBackgroundColor: '#fff',
              pointHoverBorderColor: 'rgb(255, 99, 132)'
            }
          ]
        },
        options: {
          elements: {
            line: {
              borderWidth: 3
            }
          }
        }
      }
    );
  }
}
