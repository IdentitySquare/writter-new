// import EditorJS from '@editorjs/editorjs';
import { Controller } from "@hotwired/stimulus"
// import EditorJS from '@editorjs/editorjs';
// import Header from '@editorjs/header';

export default class extends Controller {
  connect() {
    console.log('hey')
    this.editor = new EditorJS({
      holder: this.element,
      
      tools: {
        header: {
          class: Header,
          inlineToolbar: true,
          config: {
            placeholder: 'Enter a header'
          },
        },
      },

      onChange: () => {
        this.handleContentChanged();
      },

      onReady: () => {
        console.log('Editor.js is ready to work!')
      }

    });
  }


  disconnect() {
    this.editor.destroy();
  }

  
  handleContentChanged() {
    console.log('trying to save')

    this.editor.save().then((outputData) => {
      console.log(JSON.stringify(outputData))
      console.log(outputData.blocks)
      // Update hiddent field
      document.getElementById('post_body').value = JSON.stringify(outputData.blocks).toString()     
    });
  }
  


}





