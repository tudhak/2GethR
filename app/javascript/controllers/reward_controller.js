import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reward"
export default class extends Controller {
  connect() {
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('.btn-success').forEach(function (button) {
      button.addEventListener('click', function () {
        const rewardId = this.getAttribute('data-reward-id');
        markRewardAsDone(rewardId);
      });
    });

    function markRewardAsDone(rewardId) {
      // Make an AJAX request to update the reward status
      fetch(`/rewards/${rewardId}/mark_as_done`, { method: 'PATCH' })
        .then(response => response.json())
        .then(data => {
          // Handle success or update the UI accordingly
          console.log('Reward marked as done:', data);
          // You can update the UI here if needed
        })
        .catch(error => {
          console.error('Error marking reward as done:', error);
          // Handle errors if necessary
        });
    }
  });

  }
}
