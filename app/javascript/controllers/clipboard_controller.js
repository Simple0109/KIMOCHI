import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['link']

  copyToClipboard(event) {
    event.preventDefault();
    navigator.clipboard.writeText(this.linkTarget.textContent)
      .then(() => {
        alert("招待リンクをコピーしました");
      })
      .catch(err => {
        alert("招待リンクのコピーに失敗しました");
      });
  }
}
