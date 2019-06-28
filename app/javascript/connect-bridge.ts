interface CurrentWindow extends Window {
  webkit?: {
    messageHandlers: {
      GripThumb: Bridge
    },
  },
}

export interface Bridge {
  postMessage(name: string, data?: any): void
}

class FakeBridge implements Bridge {
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

export default function(window: CurrentWindow) {
  if (window.webkit) {
    return window.webkit.messageHandlers.GripThumb
  } else {
    return new FakeBridge()
  }
}
