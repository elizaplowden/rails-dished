import "jquery-bar-rating";

// We are using Le Wagon template so JQuery already installed
// import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  $('#review_rating').barrating({
    theme: 'css-stars',
    onSelect: (value, text, event) => {
      const form = $("form.review_form"); //selecting the form on the page with this class
      form.submit(); // Submitting the form with JS
    }
  });
};

export { initStarRating };
