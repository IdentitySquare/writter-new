import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["emailInput", 'editorEmails']

  add() {
    this.editorEmailsTarget.value += this.emailInputTarget.value + ','
    this.emailInputTarget.value = ''
  }
}
