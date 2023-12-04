import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-task"
export default class extends Controller {
  static targets = ["firstTitle", "secondTitle", "description", "score", "titleTemplates", "descriptionTemplates", "scoreTemplates"]

  connect() {
  }

  toggle() {
    if (this.firstTitleTarget.value === "Other") {
      this.secondTitleTarget.value = ""
      this.secondTitleTarget.classList.toggle("d-none")
      this.secondTitleTarget.classList.add("revealed")
    }
    }

  untoggle() {
      if (this.firstTitleTarget.value !== "Other" && this.secondTitleTarget.classList.contains("revealed")) {
        this.secondTitleTarget.classList.toggle("d-none")
        this.secondTitleTarget.classList.remove("revealed")
      }
    }

  fill() {
    if (this.firstTitleTarget.value !== "Other") {
      this.secondTitleTarget.value = this.firstTitleTarget.value
    }
  }

  autoComplete() {
    const titleList = this.titleTemplatesTarget.value.slice(0, -1).substr(1).replaceAll('"','').split(', ')
    const descriptionList = this.descriptionTemplatesTarget.value.slice(0, -1).substr(1).replaceAll('"','').split(', ')
    const scoreList = this.scoreTemplatesTarget.value.slice(0, -1).substr(1).replaceAll('"','').split(', ')

    for (let i = 0; i <= titleList.length; i++) {
      if (this.firstTitleTarget.value === titleList[i]) {
        this.descriptionTarget.value = descriptionList[i];
        this.scoreTarget.value = scoreList[i];
      }
      else if (this.firstTitleTarget.value === "Other") {
        this.descriptionTarget.value = "";
      }
    }
    }
  }
