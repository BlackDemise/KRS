//$(document).ready(function() {
//    $("#contact-form").submit(function(event) {
//        event.preventDefault(); // Ngăn chặn form gửi mặc định
//        var formData = {
//            name: $("#name").val(),
//            email: $("#email").val(),
//            phone: $("#phone").val(),
//            subject: $("#subject").val(),
//            message: $("#message").val()
//        };
//
//        $.ajax({
//            type: "POST",
//            url: "/contact",
//            data: formData,
//            success: function(response) {
//                $("#result").text(response);
//            },
//            error: function() {
//                $("#result").text("There was an error while sending your message.Please try again later.");
//            }
//        });
//    });
//});
$(document).ready(function() {
    $("#contact-form").submit(function(event) {
        event.preventDefault(); // Prevent default form submission
        var formData = {
            name: $("#name").val(),
            email: $("#email").val(),
            phone: $("#phone").val(),
            subject: $("#subject").val(),
            message: $("#message").val()
        };

        $.ajax({
            type: "POST",
            url: "/contact",
            data: formData,
            success: function(response) {
                // Update modal message
                $("#modalMessage").text(response);
                // Show the modal
                $("#contactResultModal").modal("show");
            },
            error: function() {
                // Update modal message for error
                $("#modalMessage").text("There was an error while sending your message. Please try again later.");
                // Show the modal
                $("#contactResultModal").modal("show");
            }
        });
    });
});
