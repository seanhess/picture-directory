$(function() {
    $(".google input.submit").click(function() {
        var url = $(".google input.url").val()
        var match = url.match(/key=(\w+)&/)
        if (!match) alert("Please enter a valid, published, google spreadsheet url")
        var key = match[1]
        window.location = "/directory/" + key
        return false
    })
})
