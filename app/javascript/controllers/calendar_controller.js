import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="calendar"
export default class extends Controller {
  static targets = [
    "calendarTitle",
    "events",
    "targetDate",
    "taskDates",
    "rewardDates",
  ];

  connect() {
    const taskDates = this.taskDatesTarget.value
      .slice(0, -1)
      .substr(1)
      .replaceAll('"', "")
      .split(", ");
    const rewardDates = this.rewardDatesTarget.value
      .slice(0, -1)
      .substr(1)
      .replaceAll('"', "")
      .split(", ");
    for (const day of this.targetDateTargets) {
      let fullDay = day.innerHTML;
      if (Number(fullDay) >= 1 && Number(fullDay) <= 9) {
        fullDay = `0${fullDay}`;
      }
      fullDay = `${this.calendarTitleTarget.dateTime}-${fullDay}`;
      if (taskDates.includes(fullDay) || rewardDates.includes(fullDay)) {
        day.classList.add("selected");
      }
    }
  }

  changeBackground(event) {
    this.targetDateTargets.forEach((day) => {
      if (day.classList.contains("event-background-color")) {
        day.classList.remove("event-background-color");
      }
    });
    const eventTarget = event.currentTarget;
    if (eventTarget.classList.contains("selected")) {
      eventTarget.classList.add("event-background-color");
    }
  }

  showEvents(event) {
    let day = event.currentTarget.innerHTML;
    if (Number(day) >= 1 && Number(day) <= 9) {
      day = `0${day}`;
    }
    const date = `${this.calendarTitleTarget.dateTime}-${day}`;
    const url = `/calendars?date=${date}`;
    fetch(url, { headers: { Accept: "text/plain" } })
      .then((response) => response.text())
      .then((data) => {
        this.eventsTarget.outerHTML = data;
      });
  }
}
