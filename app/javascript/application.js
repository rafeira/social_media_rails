// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery-ujs"


import Remote from "stimulus-remote-rails"

export default class extends Remote {
  connect() {
    super.connect()
    console.log("Do what you want here.")
  }
}