// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function searchTip() {
    
    var input = document.getElementById("search").value.toUpperCase();
    var row, row_text;
    content = document.getElementById("myContent").getElementsByTagName("tr");
    var visible = 0;
    for (i = 0; i < content.length; i++) {
        row = content[i];
        row_text = row.innerText.replace(row.getElementsByTagName('td')[2].innerText,'').toUpperCase();
        
        if (row_text.search(input) > -1) {
            row.style.display = "";
            if(visible%2 == 0)
                row.style.background = "#f2f2f2"
            else
                row.style.background = "white";
                
            visible+=1;

        } else {
            row.style.display = "none";
        }
    }
}