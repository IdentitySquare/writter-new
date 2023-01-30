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
        console.log(outputData.blocks);
        console.log(JSON.stringify({body: outputData.blocks }));
        var data = {post: {body: outputData.blocks}}
        var a = JSON.stringify(data)
        console.log(a)
        // Send the output data server for storage
        fetch("/posts/2", {
            method: "PATCH",
            body: {},
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
            },
        });
    });
  }
  


}





