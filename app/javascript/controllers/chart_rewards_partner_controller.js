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
    rewards: Object
  }

  connect() {

    console.log("hello from partner rewards chart")

    // const labels = Object.keys(this.worldPopulation);
    // const data = Object.values(this.worldPopulation);
    // console.log(labels);
    // console.log(data);

    new Chart(
      this.element,
      {
        type: 'bar',
        data: {
          labels: ["a", "b", "c"],
          datasets: [
            {
              label: 'Gender Ratio',
              data: [10, 20, 30],
              backgroundColor: [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)',
                'rgb(255, 205, 86)'
              ],
              hoverOffset: 4
            }
          ]
        },

        options: {
          scales: {
            x: {
              reverse: false
            }
          },
          indexAxis: 'y',
          elements: {
            bar: {
              borderWidth: 2,
            }
          },
          responsive: true,
          plugins: {
            legend: {
              position: 'right',
              display: false
            },
            // title: {
            //   display: true,
            //   text: 'Chart.js Horizontal Bar Chart'
            //  }
          }
        }
      }
    );
  }
}
