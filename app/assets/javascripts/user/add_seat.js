var seats = 1;

$( document ).ready(function() {
  // $('#add-seat').click(function() {
  //   $('#seat_number_' + seats).after("<br><input type='text' name='seat[]' id='seat_number_" + (seats+1) + "' required='required' placeholder='seat number " + (seats+1) + " ' class='form-control text-input'>");
  //   seats++;
  // });

  $('.add-seat-edit').click(function() {
    $('.seat_number_1').after("<tr id='seat_number_1', class='ticket'><td><label class='sr-only' for='seat'>Seat</label><input type='text' name='seat[]' id='seat' required='required' class='form-control text-input'></td><td class='remove-seat'><a class='btn btn-danger' href='#'>Remove Seat</a></td></tr>");
    seats++;
  });
});
