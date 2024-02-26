import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["tab", "panel"];

  connect() {
    this.updateTabsAndPanels();
  }

  updateTabsAndPanels() {
    const activeTab = this.tabTargets.find(tab => tab.classList.contains("active"));
    const activePanelValue = activeTab.getAttribute("data-tab-status-value");

    this.panelTargets.forEach((panel) => {
      panel.classList.toggle("hidden", panel.getAttribute("status") !== activePanelValue);
    });
  }

  switchTab(event) {
    event.preventDefault();

    this.tabTargets.forEach(tab => tab.classList.remove("active"));
    event.currentTarget.classList.add("active");

    this.updateTabsAndPanels();
  }
}
