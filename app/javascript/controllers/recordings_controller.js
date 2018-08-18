import { Controller } from "stimulus"

let unknownSong = {
  tui: "",
  artist: "",
  name: "",
}

export default class extends Controller {
  static targets = [
    "artist",
    "button",
    "form",
    "name",
    "progress",
    "tui",
  ]

  initialize() {
    this.progress = 0
    this.attempts = 0
  }

  connect() {
    if (window.webkit) {
      this.buttonTarget.classList.add("songs--record-button__enabled")
      this.formTarget.classList.remove("songs--form__enabled")
    }
  }

  trackProgress(event) {
    let progress = event.detail.progress;

    this.progress = progress;
  }

  start() {
    this.attempts++
    this.buttonTarget.disabled = true
    this.element.classList.add("songs__recording")
    this.gripthumb.postMessage("startRecording")
  }

  search(event) {
    let [song] = event.detail
    this.element.classList.remove("songs__recording")
    this.buttonTarget.disabled = false

    if (song) {
      this.submit(song)
    } else if (this.attempts < 5) {
      this.start()
    } else {
      this.submit(unknownSong)
    }
  }

  submit(song) {
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
