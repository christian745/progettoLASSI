
function searchProfile() {
    var input = document.getElementById("search").value.toUpperCase();
    var email, email_text;
    var profiles = document.getElementsByClassName("search")
    for (i = 0; i < profiles.length; i++) {
        
        email = profiles[i].getElementsByTagName('span')[0];
        email_text = email.innerText.toUpperCase();
        if (email_text.search(input) > -1) {
            profiles[i].style.display = "";
        } else {
            profiles[i].style.display = "none";
        }
    }
}