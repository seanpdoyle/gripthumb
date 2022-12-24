import "@hotwired/turbo"

import "form-request-submit-polyfill"

import AudioRecorder from "audio-recorder-polyfill"

if (!"MediaRecorder" in window) {
  window.MediaRecorder = AudioRecorder
}

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /.(js|ts)$/)
application.load(definitionsFromContext(context))
