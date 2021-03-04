import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "error", "form" ]

  declare readonly errorTarget: HTMLElement
  declare readonly formTarget: HTMLFormElement

  handleNextResponse() {
    this.errorTarget.hidden = true

    document.addEventListener("turbo:before-fetch-response", async (event: CustomEvent) => {
      const { result } = await event.detail.fetchResponse.response.json()

      if (result) {
        this.formTarget.elements["artist"].value = result.artist
        this.formTarget.elements["title"].value = result.title

        this.formTarget.requestSubmit()
      } else {
        this.errorTarget.hidden = false
      }
    }, { once: true })
  }
}
