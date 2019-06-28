import connectBridge, { Bridge } from "../connect-bridge"
import { Controller } from "stimulus"

type Song = {
  artist: string
  name: string
  title: string
  tui: string
}

const unknownSong: Song = {
  artist: "",
  name: "",
  title: "",
  tui: "",
}

export default class extends Controller {
  static targets = [
    "artist",
    "button",
    "name",
    "submit",
    "tui",
  ]
  readonly artistTarget: HTMLInputElement
  readonly buttonTarget: HTMLButtonElement
  readonly nameTarget: HTMLInputElement
  readonly submitTarget: HTMLInputElement
  readonly tuiTarget: HTMLInputElement

  attempts: number
  bridge: Bridge

  initialize() {
    this.attempts = 0
    this.bridge = connectBridge(window);
  }

  start() {
    this.attempts++
    this.buttonTarget.disabled = true
    this.element.classList.add("songs__recording")

    this.bridge.postMessage("startRecording")
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

  submit(song: Song) {
    this.attempts = 0

    this.element.classList.remove("songs__recording")
    this.buttonTarget.disabled = false

    this.artistTarget.value = song.artist
    this.nameTarget.value = song.title
    this.tuiTarget.value = song.tui

    this.triggerNecessaryFormSubmitEventBySubmitClick()
  }

  triggerNecessaryFormSubmitEventBySubmitClick() {
    this.submitTarget.click()
  }
}
