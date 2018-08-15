import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["recordButton", "results"]

  connect() {
    if (window.webkit) {
      this.recordButtonTarget.classList.add("record-button--enabled");
    }
  }

  record() {
    this.gripthumb.postMessage("startRecording")
  }

  publish(event) {
    let tracks = event.detail
    this.resultsTarget.innerHTML = JSON.stringify(tracks);
  }

  get gripthumb() {
    return window.webkit.messageHandlers.GripThumb
  }
}
