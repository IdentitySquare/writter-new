
import { Controller } from "@hotwired/stimulus"
// import EditorJS from 'editor.js';
// import EditorJS from '@editorjs/editorjs';
// import Header from '@editorjs/header';

export default class extends Controller {
  static targets = [ "render"]
  connect() {

    console.log('yahh')
    console.log(this.data.get("readOnly") == 'true')
    this.editor = new EditorJS({
      holder: this.element,
      readOnly: this.data.get("readOnly") == 'true',

      tools: {
        header: {
          class: Header,
          inlineToolbar: true,
          config: {
            placeholder: 'Enter a header'
          },
        },
        paragraph: {
          class: Paragraph,
          inlineToolbar: true,
        },
        list: {
          class: NestedList,
          inlineToolbar: true,
          config: {
            defaultStyle: 'ordered'
          },
        },
        checklist: {
          class: Checklist,
          inlineToolbar: true,
        },
        Marker: {
          class: Marker,
        },
        delimiter: Delimiter,
        quote: {
          class: Quote,
          inlineToolbar: true,
          config: {
            quotePlaceholder: 'Enter a quote',
            captionPlaceholder: 'Quote\'s author',
          },
        },
        code: CodeTool,
        inlineCode: {
          class: InlineCode
        },
        underline: Underline,
        table: {
          class: Table,
          inlineToolbar: true,
          config: {
            rows: 2,
            cols: 3,
          },
        },

      },

      data: JSON.parse(this.data.get("value")),

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
    this.editor.save().then((outputData) => {

      document.getElementById('post_body').value = JSON.stringify(outputData).toString()
    
    });
  }
  


}





