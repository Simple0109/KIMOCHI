import { Controller } from "stimulus"
export default class extends Controller {
  static targets = ["input", "preview"]

  previewImage() {
    const input = this.inputTarget
    const preview = this.previewTarget
    const files = input.files
    const width = this.data.get('width')


    if (files && files[0]) {
      const reader = new FileReader()
      reader.onload = (e) => {
        preview.innerHTML = `<img src="${e.target.result}" style="max-width: ${width}px;">`;
      }
      reader.readAsDataURL(files[0])
    }
  }
}
