import { Controller } from "@hotwired/stimulus"
// import EditorJS from 'editor.js';
// import EditorJS from '@editorjs/editorjs';
// import Header from '@editorjs/header';
export default class extends Controller {
//   static targets = [ "render"]
//   connect() {
    
//     if (this.data.get("value") !== "" && JSON.parse(this.data.get("value"))['blocks'].length > 0)  {
//       var dataValue = JSON.parse(this.data.get("value"))
//     } else {
//       var dataValue = {"time":1677155768141,"blocks":[{"id":"pgD-hmVDIY","type":"header","data":{"text":"","level":2}},{"id":"bDW9OO6bew","type":"paragraph","data":{"text":""}}],"version":"2.26.5"}
//     }
//     console.log('dataValue')
    
//     this.editor = new EditorJS({
//       holder: this.element,
//       placeholder: "Let's write an awesome story!",
//       minHeight : 0,
//       readOnly: this.data.get("readOnly") == 'true',
//       tools: {
//         header: {
//           class: Header,
//           inlineToolbar: true,
//           config: {
//             placeholder: 'Your title goes here...'
//           },
//         },
//         paragraph: {
//           class: Paragraph,
//           inlineToolbar: true,
//           config: {
//             placeholder: 'Write your idea here...'
//           },
//         },
//         list: {
//           class: NestedList,
//           inlineToolbar: true
//         },
//         Marker: {
//           class: Marker,
//         },
//         // delimiter: Delimiter,
//         // quote: {
//         //   class: Quote,
//         //   inlineToolbar: true,
//         //   config: {
//         //     quotePlaceholder: 'Enter a quote',
//         //     captionPlaceholder: 'Quote\'s author',
//         //   },
//         // },
//         // code: CodeTool,
//         // inlineCode: {
//         //   class: InlineCode
//         // },
//         underline: Underline,
//         // table: {
//         //   class: Table,
//         //   inlineToolbar: true,
//         //   config: {
//         //     rows: 2,
//         //     cols: 3,
//         //   },
//         // },
//       },
      
//       data: dataValue,
//       onChange: () => {
//         this.handleContentChanged();
//       },
//       onReady: () => {
//         console.log('Editor.js is ready to work!')
//       }
//     });
//   }
//   disconnect() {
//     this.editor.destroy();
//   }
//   handleContentChanged() {
//     var timeoutId;
//     // this.saveTask();
//     this.editor.save().then((outputData) => {
      
//       document.getElementById('saveStatus').innerHTML = ""
//       document.getElementById('post_draft_body').value = JSON.stringify(outputData).toString()
//       clearTimeout(timeoutId);
//       timeoutId = setTimeout(this.savePost(), 1000)
      
//     });
//   }
  
//   savePost () { 
//     document.getElementById('saveStatus').innerHTML = "- Saving..."
//     const postForm = document.querySelector(".simple_form")
//     postForm.requestSubmit();
    
//   }
}
