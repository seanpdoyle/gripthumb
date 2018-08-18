let bridge;

if (window.webkit) {
  bridge = window.webkit.messageHandlers.GripThumb
} else {
  bridge = {
    postMessage() {
      let results = [{
        artist: "Duster",
        title: "Echo, Bravo",
        tui: "8420973",
      }]
      let event = new CustomEvent("gripthumb:results", { detail: results })

      setTimeout(() => document.dispatchEvent(event), 3000)
    }
  }
}

export default bridge;
