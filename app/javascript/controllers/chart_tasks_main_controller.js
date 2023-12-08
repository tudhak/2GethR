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
              label: 'You',
              data: data_user,
              fill: true,
              backgroungColor: 'rgb(128, 89, 255, 0.2)',
              borderColor: 'rgb(128, 89, 255)',
              pointBackgroundColor: 'rgb(128, 89, 255)',
              pointBorderColor: '#fff',
              pointHoverBackgroundColor: '#fff',
              pointHoverBorderColor: 'rgb(128, 89, 255)'
            }, {
              label: 'Your partner',
              data: data_partner,
              fill: true,
              backgroungColor: 'rgb(226, 100, 108, 0.2)',
              borderColor: 'rgb(226, 100, 108)',
              pointBackgroundColor: 'rgb(226, 100, 108)',
              pointBorderColor: '#fff',
              pointHoverBackgroundColor: '#fff',
              pointHoverBorderColor: 'rgb(226, 100, 108)'
            }
          ]
        },
        options: {
          plugins: {
            legend: {
              display: false
            }
          },
          scales: {
            r: {
              suggestedMin: 0,
              suggestedMax: 1,
              pointLabels: { // nom de colonne
                font: {
                  size: 18
                }
              },
              ticks: {
                display:false
                // étiquettes graduation
              },
              angleLines: {
                color: 'rgba(100, 100, 100, 0.8)'
              },
            },
          },
          ticks: {
            suggestedMin: 0,
            suggestedMax: 1,
            stepSize: 0.2,
          },
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
