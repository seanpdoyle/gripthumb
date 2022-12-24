import "@hotwired/turbo-rails"

import AudioRecorder from "audio-recorder-polyfill"

if (!"MediaRecorder" in window) {
  window.MediaRecorder = AudioRecorder
}

import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /.(js|ts)$/)
application.load(definitionsFromContext(context))
