import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["emailInput", 'editorEmails', 'newEmails', 'adminEmailInput','adminEmails' , 'newAdmins']

  addEditor() {
    this.editorEmailsTarget.value += this.emailInputTarget.value + ','
    
    // Create a new div element
    const newSpan = document.createElement("div");
    newSpan.textContent = this.emailInputTarget.value + ' ';
    newSpan.classList.add("border", "rounded-full", "border-gray-200", "px-3", "py-2")
    
    // Append the new element to the target div
    this.newEmailsTarget.appendChild(newSpan);

    // Clear the input field value
    this.emailInputTarget.value = '' 
  }


  addAdmin() {
    this.adminEmailsTarget.value += this.adminEmailInputTarget.value + ','
    
    // Create a new div element
    const newSpan = document.createElement("div");
    newSpan.textContent = this.adminEmailInputTarget.value + ' ';
    newSpan.classList.add("border", "rounded-full", "border-gray-200", "px-3", "py-2")
    
  
    // Append the new element to the target div
    this.newAdminsTarget.appendChild(newSpan);

    // Clear the input field value
    this.adminEmailInputTarget.value = '' 
  }
}
