import "form-request-submit-polyfill"

import AudioRecorder from "audio-recorder-polyfill"

if (!"MediaRecorder" in window) {
  window.MediaRecorder = AudioRecorder
}
