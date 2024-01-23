import { Controller } from "stimulus";

export default class extends Controller {
  
  go(event) {
    event.preventDefault();

    const url = event.currentTarget.dataset.url;

    if (url) {
      window.location.href = url;
    }
  }
}