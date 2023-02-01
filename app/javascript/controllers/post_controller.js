import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "render"]
  connect() {

    let editorjs_clean_data =  JSON.parse(this.data.get("value"));
    
    const edjsParser = edjsHTML();

    let html = edjsParser.parse(editorjs_clean_data);

    this.renderTarget.innerHTML = html.join("")
  }

}
