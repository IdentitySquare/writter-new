class ChecklistBlockRenderer < RenderEditorjs::Blocks::Base
  def render(data)
    
    checkboxes = ""

    # loop through each item in the checklist and create a checkbox for it
    data["items"].each do |item|
      checked = item["checked"] ? "checked" : ""
      checkboxes += "<div><input disabled class='border-gray-300 w-5 h-5 text-sky-500   rounded-full' type='checkbox' 
                    #{checked}><label class=' ml-2 font-serif mb-2' >#{item['text']}</label></div>"
    end

    # wrap the checkboxes in a div with a class of "checklist"
    "<div class='checklist'>#{checkboxes}</div>"
  end
end