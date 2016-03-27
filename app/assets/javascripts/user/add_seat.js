var seats = 1;

$( document ).ready(function() {
  $('#add-seat').click(function() {
    console.log("HI");
    console.log(seats);
    $('#seat_number_' + seats).after("<br><input type='text' name='seat_number' id='seat_number_" + (seats+1) + "' required='required' placeholder='seat number " + (seats+1)
     + " ' class='form-control text-input'>");
    seats++;
  });
});
