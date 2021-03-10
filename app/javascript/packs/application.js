// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .
//= require masonry/jquery.masonry

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports
import { initSelect2 } from '../components/init_select2';
import { initAddNewField } from '../components/recipe_new_form';
import { initUpdateNavbarOnScroll } from '../components/navbar';
import { previewImageOnFileSelect } from '../components/user_image_preview';
import { initStarRating } from '../plugins/init_star_rating';

document.addEventListener('turbolinks:load', () => {
  initSelect2();
  initAddNewField();
  initUpdateNavbarOnScroll();
  previewImageOnFileSelect();
  initStarRating();
});



