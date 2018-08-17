import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "artist", "song", "recordButton"]

  connect() {
    if (window.webkit) {
      this.recordButtonTarget.classList.add("songs--record-button__enabled")
      this.formTarget.classList.remove("songs--form__enabled")
    }
  }

  record() {
    this.recordButtonTarget.disabled = true
    this.element.classList.add("songs__recording")
    this.gripthumb.postMessage("startRecording")
  }

  publish(event) {
    let [track] = event.detail
    this.element.classList.remove("songs__recording")
    this.recordButtonTarget.disabled = false

    this.artistTarget.value = track.artist
    this.songTarget.value = track.title
    this.formTarget.querySelector('[type="submit"]').click()
  }

  get gripthumb() {
    return window.webkit.messageHandlers.GripThumb
  }
}
