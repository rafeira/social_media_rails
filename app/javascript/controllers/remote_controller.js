import Remote from "stimulus-remote-rails"

export default class extends Remote {
  connect() {
    super.connect()
    console.log("Do what you want here.")
  }
}