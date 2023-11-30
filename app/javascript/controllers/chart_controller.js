import { Controller } from "@hotwired/stimulus";
import { Chart } from "chart.js";
import * as Chartjs from "chart.js" ;


const controllers = Object.values(Chartjs).filter(
  (chart) => chart.id !== undefined
) ;
Chart.register(...controllers) ;

// Connects to data-controller="chart"
export default class extends Controller {

  worldPopulation = {
    "men": 504,
    "women": 496
  };

  connect() {
    console.log("hello from chart")
    const labels = Object.keys(this.worldPopulation);
    // const data = Object.values(this.worldPopulation);
    console.log(labels);
    // console.log(values);

    new Chart(
      this.element,
      {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [
            {
              label: 'Gender Ratio',
              data: {
                "men": 504,
                "women": 496
              },
              backgroundColor: [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)',
                'rgb(255, 205, 86)'
              ],
              hoverOffset: 4
            }
          ]
        }
      }
    );
  }
}
