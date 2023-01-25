import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = [ "username", "usernameTaken", "saveButton", "minLength"]

    checkUsername(event) {
        const target = this.saveButtonTarget;
        event.preventDefault()

        if (this.usernameTarget.value.length < 4) {
            console.log(this.usernameTarget.value);
            this.minLengthTarget.style.display = 'block';
            target.disabled = true;
            target.classList.add("bg-disable");
            return;
        } else {
            this.minLengthTarget.style.display = 'none';
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
                this.usernameTakenTarget.style.display = 'block';            
                target.disabled = true;
                target.classList.add("bg-disable");

            } else {
                
                this.usernameTakenTarget.style.display = 'none';           
                target.disabled = false;
                target.classList.remove("bg-disable");
            }
        });
    }
}