$(document).ready(function () {
        $("#toggleOrderDetails").click(function () {
            $("#orderDetails").slideToggle();
            let btnText = $(this).text().trim();
            if (btnText === "View Order Details") {
                $(this).text("Hide Order Details");
            } else {
                $(this).text("View Order Details");
            }
        });
    });