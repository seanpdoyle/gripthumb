import { Controller } from "stimulus"

let unknownSong = {
  tui: "",
  artist: "",
  name: "",
}

export default class extends Controller {
  static targets = [
    "artist",
    "form",
    "name",
    "progress",
    "recordButton",
    "tui",
  ]

  initialize() {
    this.progress = 0
    this.attempts = 0
  }

  connect() {
    if (window.webkit) {
      this.recordButtonTarget.classList.add("songs--record-button__enabled")
      this.formTarget.classList.remove("songs--form__enabled")
    }
  }

  trackProgress(event) {
    let progress = event.detail.progress;

    this.progress = progress;
  }

  record() {
    this.attempts++
    this.recordButtonTarget.disabled = true
    this.element.classList.add("songs__recording")
    this.gripthumb.postMessage("startRecording")
  }

  publish(event) {
    let [song] = event.detail
    this.element.classList.remove("songs__recording")
    this.recordButtonTarget.disabled = false

    if (song) {
      this.searchForSong(song)
    } else if (this.attempts < 5) {
      this.record()
    } else {
      this.searchForSong(unknownSong)
    }
  }

  searchForSong(song) {
    this.attempts = 0
    this.artistTarget.value = song.artist
    this.nameTarget.value = song.title
    this.tuiTarget.value = song.tui
    this.formTarget.querySelector('[type="submit"]').click()
  }

  get gripthumb() {
    return window.webkit.messageHandlers.GripThumb
  }

  set progress(percent) {
    this.progressTarget.value = percent
    this.progressTarget.text = `${percent}%`
  }

  get progress() {
    return parseInt(this.progressTarget.value, 10);
  }
}
