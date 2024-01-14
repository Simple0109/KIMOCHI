import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (event) => {
      if (!confirm('ログアウトしますか？')) {
        event.preventDefault();
      }
    });
  }
}