import "jquery-bar-rating";

// We are using Le Wagon template so JQuery already installed
// import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  // to enable the stars. ID found by using inspector
  $('#review_rating').barrating({
    // passing the object to the method to select the jquery theme we want
    theme: 'css-stars',
    // submit the form automatically when stars are selected
    onSelect: (value, text, event) => {
      const form = $("form.review_form"); //selecting the form on the page with this class
      form.submit(); // Submitting the form with JS
    }
  });
};

export { initStarRating };
