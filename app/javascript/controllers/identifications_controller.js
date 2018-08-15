import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "artist", "title", "recordButton"]

  connect() {
    if (window.webkit) {
      this.recordButtonTarget.classList.add("record-button--enabled")
      this.formTarget.classList.remove("form--enabled")
    }
  }

  record() {
    this.recordButtonTarget.disabled = true
    this.element.classList.add("identifications--recording")
    this.gripthumb.postMessage("startRecording")
  }

  publish(event) {
    let [track] = event.detail
    this.element.classList.remove("identifications--recording")
    this.recordButtonTarget.disabled = false

    this.artistTarget.value = track.artist
    this.titleTarget.value = track.title
    this.formTarget.submit()
  }

  get gripthumb() {
    return window.webkit.messageHandlers.GripThumb
  }
}
