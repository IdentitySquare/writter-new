import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "trigger", "dropdown", "closeImage", "openImage"]


    toggleDropdown(){
      
      var wasOpen = !this.dropdownTarget.classList.contains('hidden')

      if (wasOpen){
        this.dropdownTargets.forEach(element => element.classList.add('hidden'));
        this.closeImageTarget.classList.remove('hidden');
        this.openImageTarget.classList.add('hidden')
      } else{
        this.dropdownTargets.forEach(element => element.classList.remove('hidden'));
       
        this.openImageTarget.classList.remove('hidden');
        this.closeImageTarget.classList.add('hidden')
      }

    }

}