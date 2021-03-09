import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
      placeholder: "What's in your fridge?"
      // theme: "flat"
  });
};

// $(".js-example-theme-multiple").select2({
//   theme: "classic"
// });

export { initSelect2 };
