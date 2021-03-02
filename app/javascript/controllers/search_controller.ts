import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  declare readonly formTarget: HTMLFormElement

  handleNextResponse() {
    document.addEventListener("turbo:before-fetch-response", async (event: CustomEvent) => {
      const { result } = await event.detail.fetchResponse.response.json()

      if (result) {
        this.formTarget.elements["artist"].value = result.artist
        this.formTarget.elements["title"].value = result.title

        this.formTarget.requestSubmit()
      }
    }, { once: true })
  }
}
