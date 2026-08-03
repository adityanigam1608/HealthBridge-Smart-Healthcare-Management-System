function validateRegisterForm() {
    let name = document.forms["registerForm"]["fullName"].value;
    let email = document.forms["registerForm"]["email"].value;
    let password = document.forms["registerForm"]["password"].value;

    if (name.length < 3) {
        alert("Name must be at least 3 characters");
        return false;
    }

    if (!email.includes("@")) {
        alert("Enter valid email");
        return false;
    }

    if (password.length < 5) {
        alert("Password must be at least 5 characters");
        return false;
    }

    return true;
}