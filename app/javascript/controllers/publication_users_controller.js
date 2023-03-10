import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["emailInput", 'editorEmails', 'newEmails']

  add() {
    this.editorEmailsTarget.value += this.emailInputTarget.value + ','
    
    console.log(this.newEmailsTarget)
    const newSpan = document.createElement('span');
    newSpan.textContent = this.emailInputTarget.value + ' ';
    // Append the new span element to the target div
    this.newEmailsTarget.appendChild(newSpan);
    // Clear the input field value
    this.emailInputTarget.value = ''
   
  }
}
