import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "progress" ]

  declare readonly progressTarget: HTMLProgressElement
  timeout: NodeJS.Timeout

  async start() {
    const chunks = []

    const recorder = new MediaRecorder(await navigator.mediaDevices.getUserMedia({ audio: true }))
    recorder.ondataavailable = ({ data }) => { chunks.push(data) }
    recorder.onstop = () => {
      this.progressTarget.value = 0

      const file = new File(chunks, "audio.ogg", { type: "audio/ogg; codecs=opus" })

      this.element.addEventListener("turbo:submit-start", (event: CustomEvent) => {
        event.detail.formSubmission.formData.set("file", file)
      }, { once: true })

      if (this.element instanceof HTMLFormElement) {
        this.element.requestSubmit()
      }
    }

    this.progressTarget.removeAttribute("value")
    recorder.start()

    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => recorder.stop(), 8000)
  }
}
