// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

import './bootstrap/index.js'
import '@fortawesome/fontawesome-free/js/all'

const images = require.context('./images', true)
const imagePath = (name) => images(name, true)

document.addEventListener('turbolinks:load', () => {
  $('[data-toggle="tooltip"]').tooltip()
})
