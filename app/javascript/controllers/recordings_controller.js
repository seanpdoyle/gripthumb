import Bridge from "../bridge"
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
    this.attempts = 0
  }

  start() {
    this.attempts++
    this.buttonTarget.disabled = true
    this.element.classList.add("songs__recording")
    this.interval = setInterval(() => this.progress += 3, 100)

    Bridge.postMessage("startRecording")
  }

  search(event) {
    let [song] = event.detail

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
    clearInterval(this.interval)

    this.element.classList.remove("songs__recording")
    this.buttonTarget.disabled = false

    this.artistTarget.value = song.artist
    this.nameTarget.value = song.title
    this.tuiTarget.value = song.tui
    this.formTarget.querySelector('[type="submit"]').click()
  }

  get progress() {
    return parseInt(this.progressTarget.value, 10);
  }

  set progress(progress) {
    this.progressTarget.value = progress
    this.progressTarget.text = `${progress.value}%`
  }
}