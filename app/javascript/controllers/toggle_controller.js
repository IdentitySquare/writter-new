import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "toggle", "span", 'form' ]

    submitForm(){
      this.formTarget.submit();
    }

    disableFields(){
      document.getElementById("user_notifications_freq_0").disabled = true;
    }
}