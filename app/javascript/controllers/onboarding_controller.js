import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "username", "usernameTaken", "saveButton", "errorMessage"]

    checkUsername(event) {
        const target = this.saveButtonTarget;
        event.preventDefault()

        if (this.usernameTarget.value.length < 4 ) {
            console.log(this.usernameTarget.value);
            this.errorMessageTarget.classList.remove("invisible")
            this.errorMessageTarget.innerHTML = 'Username must contain atleast 4 characters'
            target.disabled = true;
            target.classList.add("bg-disable");

            return;
        } else {
            this.errorMessageTarget.classList.add("invisible")
            target.disabled = false;
            target.classList.remove("bg-disable");
        }   

        fetch('/onboarding/checkUsername', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({ username: this.usernameTarget.value })
        })
        .then(response => response.json())
        .then(data => {
            
            if (data.status == 'error') {
                this.errorMessageTarget.classList.remove("invisible")
                this.errorMessageTarget.innerHTML = 'Username already taken'
                target.disabled = true;
                target.classList.add("bg-disable");

            } else {
                
                this.errorMessageTarget.classList.add("invisible")
                target.disabled = false;
                target.classList.remove("bg-disable");
            }
        });


    }
}