import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "toggle", "span"]


    changeFormField(){
    console.log('ji')
      var was_enabled = this.toggleTarget.classList.contains('bg-emerald-800')

      if (was_enabled){
        this.toggleTarget.classList.add('bg-gray-200')
        this.toggleTarget.classList.remove('bg-emerald-800')
        this.spanTarget.classList.add('translate-x-5')
        this.spanTarget.classList.remove('translate-x-0')
      } else{
        this.toggleTarget.classList.add('bg-emerald-800')
        this.toggleTarget.classList.remove('bg-gray-200')
        this.spanTarget.classList.add('translate-x-0')
        this.spanTarget.classList.remove('translate-x-5')
      }



    }

}