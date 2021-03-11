// const initUpdateNavbarOnScroll = () => {
//   const navbar = document.querySelector('.navbar-lewagon');
//   if (navbar) {
//     window.addEventListener('scroll', () => {
//       // console.log('scrolling');
//       // console.log(`scrollY: ${window.scrollY}`);
//       // console.log(`inner height: ${window.innerHeight}`);
//       if (window.scrollY >= window.innerHeight) {
//         navbar.classList.add('navbar-lewagon-white');
//       } else {
//         navbar.classList.remove('navbar-lewagon-white');
//       }
//     });
//   }
// }


const initUpdateNavbarOnScroll = () => {
  $(window).scroll(function () {
  if ($(window).scrollTop() >= 40) {
  $('.navbar-lewagon').css('background','white',);
  } else {
  $('.navbar-lewagon').css({'box-shadow':'0 0px 0px 0 rgba(0, 0, 0, 10)', 'background':'transparent'});
  }
  });
}


export { initUpdateNavbarOnScroll };
