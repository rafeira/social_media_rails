# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'https://ga.jspm.io/npm:@hotwired/stimulus@3.0.1/dist/stimulus.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'stimulus-remote-rails', to: 'https://ga.jspm.io/npm:stimulus-remote-rails@4.0.0/dist/stimulus-remote-rails.es.js'
pin 'jquery', to: 'jquery.js'
pin 'jquery_ujs', to: 'jquery_ujs.js'
