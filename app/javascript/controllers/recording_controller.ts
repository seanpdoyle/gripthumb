import { Controller } from "@hotwired/stimulus"
import { TurboBeforeFetchResponseEvent } from "@hotwired/turbo"

export default class extends Controller<HTMLFormElement> {
  static targets = [ "error", "progress" ]

  declare readonly errorTargets: HTMLElement[]
  declare readonly progressTarget: HTMLProgressElement
  timeoutId: NodeJS.Timeout

  async start() {
    const chunks = []

    const stream = await navigator.mediaDevices.getUserMedia({ audio: true })
    const recorder = new MediaRecorder(stream)
    recorder.ondataavailable = ({ data }) => { chunks.push(data) }
    recorder.onstop = () => {
      this.progressTarget.value = 0

      const file = new File(chunks, "audio.ogg", { type: "audio/ogg; codecs=opus" })

      this.element.addEventListener("turbo:submit-start", (event: CustomEvent) => {
        event.detail.formSubmission.formData.set("file", file)
      }, { once: true })

      this.element.requestSubmit()

      stream.getTracks().forEach(track => track.stop())
    }

    this.progressTarget.removeAttribute("value")
    recorder.start()

    clearTimeout(this.timeoutId)
    this.timeoutId = setTimeout(() => recorder.stop(), 8000)
  }

  presentError({ detail: { fetchResponse } }: TurboBeforeFetchResponseEvent) {
    for (const errorTarget of this.errorTargets) {
      errorTarget.hidden = fetchResponse.succeeded
    }
  }
}
