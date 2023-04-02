
import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage";
// import EditorJS from 'editor.js';
// import EditorJS from '@editorjs/editorjs';
// import Header from '@editorjs/header';

export default class extends Controller {
  static targets = [ "render"]
  connect() {
    
    if (this.data.get("value") !== "" && JSON.parse(this.data.get("value"))['blocks'].length > 0)  {
      var dataValue = JSON.parse(this.data.get("value"))
    } else {
      var dataValue = {"time":1677155768141,"blocks":[{"id":"pgD-hmVDIY","type":"header","data":{"text":"","level":2}},{"id":"bDW9OO6bew","type":"paragraph","data":{"text":""}}],"version":"2.26.5"}
    }

    

    
    this.editor = new EditorJS({
      holder: this.element,
      placeholder: "Let's write an awesome story!",
      minHeight : 0,
      readOnly: this.data.get("readOnly") == 'true',

      tools: {
        header: {
          class: Header,
          inlineToolbar: true,
          config: {
            placeholder: 'Your title goes here...'
          },
        },
        paragraph: {
          class: Paragraph,
          inlineToolbar: true,
          config: {
            placeholder: 'Write your idea here...'
          },
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

        image: {
          class: ImageTool,
          config: {
            
          },

          uploader: {
            uploadByFile(file) {
              const url = "/rails/active_storage/direct_uploads";
              const upload = new DirectUpload(file, url);
              console.log('yeah')
              console.log(url)
              return new Promise(function (resolve, reject) {
                upload.create((error, blob) => {
                  if (error) {
                    reject(error);
                  } else {
                    fetch(`/blocks/get_image_url?attachable_sgid=${blob.attachable_sgid}`)
                      .then((response) => response.json())
                      .then((imageUrlResp) => {
                        console.log(imageUrlResp);
                        resolve({
                          success: 1,
                          file: {
                            url: imageUrlResp.url,
                            attachable_sgid: blob.attachable_sgid,
                          },
                        });
                      });
                  }
                });
              });
            }
          }

          
        }

      },

      
      data: dataValue,

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
    var timeoutId;
    // this.saveTask();
    this.editor.save().then((outputData) => {
      
      document.getElementById('saveStatus').innerHTML = ""
      document.getElementById('post_draft_body').value = JSON.stringify(outputData).toString()
      clearTimeout(timeoutId);

      timeoutId = setTimeout(this.savePost(), 1000)
      

    });
  }
  
  savePost () { 
    document.getElementById('saveStatus').innerHTML = "- Saving..."
    const postForm = document.querySelector(".simple_form")
    postForm.requestSubmit();
    
  }

}





