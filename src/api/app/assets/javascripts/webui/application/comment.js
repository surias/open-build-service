// Expand the comment textarea to fit the text
// as it's being typed.
function sz(t) {
    var a = t.value.split('\n');
    var b = 1;
    for (var x = 0; x < a.length; x++) {
        if (a[x].length >= t.cols) b += Math.floor(a[x].length / t.cols);
    }
    b += a.length;
    if (b > t.rows) t.rows = b;
}

function setup_comment_page() {
    // setup toggle events
    $('.togglable_comment').click(function () {
        var toggleid = $(this).data("toggle");
        $("#" + toggleid).toggle();
    });

    // prevent duplicate comment submissions
    $('.comment_new').submit(function() {
        $(this).find('input[type="submit"]').prop('disabled', true);
    });
}
