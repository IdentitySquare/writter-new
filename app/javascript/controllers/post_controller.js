import { Controller } from "@hotwired/stimulus"

function debounce(func, timeout = 300){
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => { func.apply(this, args); }, timeout);
  };
}

export default class extends Controller {
  static targets = [ "body"]
 
  connect() {
    // wait for user to stop typing
    this.processChanges = debounce(() => this.saveInput());

    // handle image saving
    // Get the Trix editor element
    const editor = this.element.querySelector("trix-editor");
    
    // Listen for the trix-attachment-add event
    editor.addEventListener("trix-attachment-add", (event) => {
      
      const attachment = event.attachment;
      // If the attachment is an image, call the saveChange function
      if (attachment.file) {
        // wait for image to be attached (Image doesnt save if no waiting time)
        this.timeoutID = setTimeout(() => {
          this.saveInput();
          console.log('save called')
        }, 5000);
        
      }
    });
  }
    
  saveInput(){
    document.getElementById('saveStatus').innerHTML = "- Saving..."
    const postForm = document.querySelector(".simple_form")
    postForm.requestSubmit();
  }

  clearStatus(){
    console.log('ih')
    document.getElementById('saveStatus').innerHTML = ""
  }
  
}
