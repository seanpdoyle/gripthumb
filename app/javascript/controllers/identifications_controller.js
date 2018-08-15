import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["results"]

  record() {
    this.gripthumb.postMessage("startRecording")
  }

  publish(event) {
    let tracks = event.detail
    this.resultsTarget.innerHTML = JSON.stringify(tracks);
  }

  get gripthumb() {
    return webkit.messageHandlers.GripThumb
  }
}
