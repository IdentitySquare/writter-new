import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "body"]
  connect(){
    console.log("hi");
  }

  saveChange() {
    var timeoutId;
    document.getElementById('saveStatus').innerHTML = ""

    clearTimeout(timeoutId);
    timeoutId = setTimeout(this.savePost(), 1000)
  }

  savePost () { 
    document.getElementById('saveStatus').innerHTML = "- Saving..."
    const postForm = document.querySelector(".simple_form")
    postForm.requestSubmit();
    
  }
}
