$(document).ready(function() {
    if (typeof notLoggedIn !== "undefined" && notLoggedIn) {
        $('#loginModal').modal('show'); // Show popup
        setTimeout(function() {
            window.location.href = 'Home'; // Redirect to Home Servlet
        }, 3000);
    }
});
