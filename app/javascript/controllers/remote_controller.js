import Remote from "stimulus-remote-rails"

export default class extends Remote {
  connect() {
    super.connect()
    console.log(this)
    this.element.addEventListener('click', (event) => {
        
        if (this.element.textContent == "Descurtir"){
            this.element.classList.remove('is-danger')
            this.element.classList.add('is-success')
            this.element.textContent = "Curtir"
        } else {
            this.element.textContent = "Descurtir"
            this.element.classList.remove('is-success')
            this.element.classList.add('is-danger')
        }
    })
  }
}