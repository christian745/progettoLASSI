function searchSchedule() {
    var input = document.getElementById("search").value.toUpperCase();
    var search_text;
    var schedules = document.getElementsByClassName("search")
    for (i = 0; i < schedules.length; i++) {
        search_text = ""
        for (j = 0; j < schedules[i].getElementsByClassName("search-schedule").length; j++ ){
            search_text += schedules[i].getElementsByClassName("search-schedule")[j].innerText.toUpperCase();
            search_text += " ";
        }
        if (search_text.search(input) > -1) {
            schedules[i].style.display = "";
        } else {
            schedules[i].style.display = "none";
        }
    }
}