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

    this.tabTargets.forEach(tab =>  {
      tab.classList.remove("active");
      tab.querySelector('div').classList.remove('text-blue-600');
      tab.querySelector('div').classList.remove('border-blue-500')
    });
    event.currentTarget.classList.add("active");
    event.currentTarget.querySelector('div').classList.add('text-blue-600');
    event.currentTarget.querySelector('div').classList.add('border-blue-500');

    this.updateTabsAndPanels();
  }
}
