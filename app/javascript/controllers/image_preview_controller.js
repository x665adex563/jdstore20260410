import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview", "placeholder"]

  change(event) {
    const input = event.target

    if (input.files && input.files[0]) {
      const file = input.files[0]
      const reader = new FileReader()

      reader.onload = (e) => {
        this.previewTarget.src = e.target.result
        this.previewTarget.classList.remove("hidden")

        this.placeholderTarget.classList.add("hidden")
        this.placeholderTarget.classList.remove("flex")
      }

      reader.readAsDataURL(file)
    } else {
      this.previewTarget.src = ""
      this.previewTarget.classList.add("hidden")

      this.placeholderTarget.classList.remove("hidden")
      this.placeholderTarget.classList.add("flex")
    }
  }
}
