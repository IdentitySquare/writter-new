import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "toggle", "fields", 'form' ]

    submitForm(){
      this.formTarget.submit();
    }

    disableFields(){
      if (this.toggleTarget.checked == true) {
        document.querySelectorAll('input[type=radio]').forEach((radio) => {
          radio.disabled = false;
          
        });
        this.fieldsTarget.classList.remove('opacity-25')
      } else {
        document.querySelectorAll('input[type=radio]').forEach((radio) => {
          radio.disabled = true;
        });
        this.fieldsTarget.classList.add('opacity-25')
      }
    }
}