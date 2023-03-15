import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["emailInput", 'editorEmails', 'newEmails']

  addEditor() {
    this.editorEmailsTarget.value += this.emailInputTarget.value + ','
    
    console.log(this.newEmailsTarget)
    const newSpan = document.createElement("div");
    newSpan.textContent = this.emailInputTarget.value + ' ';
    newSpan.classList.add("border", "rounded-full", "border-gray-200", "px-3", "py-2")
    
    // Append the new span element to the target div
    this.newEmailsTarget.appendChild(newSpan);



    // Clear the input field value
    this.emailInputTarget.value = ''
   
  }
}
