document.addEventListener("DOMContentLoaded", function () {
    const addToCartForms = document.querySelectorAll("form[action='CartServlet']");
    const viewCartButton = document.getElementById("view-cart");

    // Check and update the "View Cart" button visibility
    function updateViewCartButton() {
        if (viewCartButton) {
            viewCartButton.style.display = "inline-block"; // Show the button when cart is not empty
        }
    }

    // Add event listeners to the add-to-cart forms
    addToCartForms.forEach(form => {
        form.addEventListener("submit", function () {
            updateViewCartButton(); // Ensure the cart button is visible
        });
    });

    // Ensure the View Cart button appears if the cart already has items
    updateViewCartButton();
});
