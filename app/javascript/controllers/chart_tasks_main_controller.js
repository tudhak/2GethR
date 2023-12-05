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
    usertasks: Object,
    partnertasks: Object
  }

  connect() {

    console.log("hello from tasks chart")

    const labels = Object.keys(this.usertasksValue);
    const data_user = Object.values(this.usertasksValue);
    const data_partner = Object.values(this.partnertasksValue);
    console.log(labels)
    console.log(data_user)
    console.log(data_partner)


    new Chart(
      this.element,
      {
        type: 'radar',
        data: {
          labels: labels,
          datasets: [
            {
              label: 'user',
              data: data_user,
              fill: true,
              backgroungColor: 'rgb(255, 99, 132, 0.2)',
              borderColor: 'rgb(255, 99, 132)',
              pointBackgroundColor: 'rgb(255, 99, 132)',
              pointBorderColor: '#fff',
              pointHoverBackgroundColor: '#fff',
              pointHoverBorderColor: 'rgb(255, 99, 132)'
            }, {
              label: 'partner',
              data: data_partner,
              fill: true,
              backgroungColor: 'rgb(155, 200, 30, 0.2)',
              borderColor: 'rgb(155, 200, 30)',
              pointBackgroundColor: 'rgb(155, 200, 30)',
              pointBorderColor: '#fff',
              pointHoverBackgroundColor: '#fff',
              pointHoverBorderColor: 'rgb(155, 200, 30)'
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
