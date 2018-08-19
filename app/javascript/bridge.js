let bridge;

if (window.webkit) {
  bridge = window.webkit.messageHandlers.GripThumb
} else {
  bridge = {
    postMessage() {
      let results = [{
        artist: "The Righteous Brothers",
        title: "Unchained Melody",
        tui: "181482457",
      }]
      let event = new CustomEvent("gripthumb:results", { detail: results })

      setTimeout(() => document.dispatchEvent(event), 3000)
    }
  }
}

export default bridge;
