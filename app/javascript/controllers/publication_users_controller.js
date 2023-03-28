import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["emailInput", 'form', 'editorEmails', 'newEmails', 'adminEmailInput','adminEmails' , 'newAdmins', 'svg']

  
  addEditor() {
    
    // Create a new div element
    const newSpan = document.createElement("div");

    const textSpan = document.createElement("span");
    textSpan.classList.add("editor")
    textSpan.style.display = 'inline-block'; 
    textSpan.textContent = this.emailInputTarget.value + ' ';
    newSpan.appendChild(textSpan);
    
    // add svg after text content
    const svgSpan = document.createElement("span");
    svgSpan.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>';
    svgSpan.style.display = 'inline-block'; 
    svgSpan.style.verticalAlign = 'middle';
    newSpan.appendChild(svgSpan);
    svgSpan.addEventListener('click', () => {
      newSpan.remove();
    });

    
    newSpan.classList.add("border", "rounded-full", "border-gray-200", "px-3", "py-2")
    
    // Append the new element to the target div
    this.newEmailsTarget.appendChild(newSpan);

    // Clear the input field value
    this.emailInputTarget.value = '' 
  }

  addAdmin() {
    
    
    // Create a new div element
    const newSpan = document.createElement("div");

    const textSpan = document.createElement("span");
    textSpan.classList.add("admin")
    textSpan.style.display = 'inline-block'; 
    textSpan.textContent = this.adminEmailInputTarget.value + ' ';
    newSpan.appendChild(textSpan);
    
    // add svg after text content
    const svgSpan = document.createElement("span");
    svgSpan.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>';
    svgSpan.style.display = 'inline-block'; 
    svgSpan.style.verticalAlign = 'middle';
    newSpan.appendChild(svgSpan);
    svgSpan.addEventListener('click', () => {
      newSpan.remove();
    });

    
    newSpan.classList.add("border", "rounded-full", "border-gray-200", "px-3", "py-2")
    
  
    // Append the new element to the target div
    this.newAdminsTarget.appendChild(newSpan);

    // Clear the input field value
    this.adminEmailInputTarget.value = '' 
  }

  removeEditor(event){
    event.target.parentElement.remove();
  }

  getFinalEditors(){
    
    const editors = document.getElementsByClassName('editor'); // get all elements with class name "editor"
    const texts = Array.from(editors).map((element) => element.textContent.replace(/[\r\n]/gm, '')); // extract text content of each element

    const commaSeparatedTexts = texts.join(', '); // join text content into a comma-separated list
    this.editorEmailsTarget.value = commaSeparatedTexts
    
    console.log(commaSeparatedTexts); // output comma

    const admins = document.getElementsByClassName('admin'); // get all elements with class name "editor"
    const texts2 = Array.from(admins).map((element) => element.textContent.replace(/[\r\n]/gm, '').trim()); // extract text content of each element

    const commaSeparatedTexts2 = texts2.join(', '); // join text content into a comma-separated list
    if (commaSeparatedTexts2.length < 1) {
      alert("Please add at least one admin")
      return;
    }
    this.adminEmailsTarget.value = commaSeparatedTexts2
    
    
    this.formTarget.submit()  
  }

  getFinalAdmins(){
    
  }
}
