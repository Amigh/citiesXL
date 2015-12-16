var ready, set_positions;

set_positions = function(){
    // loop through and give each task a data-pos
    // attribute that holds its position in the DOM
    $('.scard').each(function(i){
        if ($(this).data("page") != '')
            $(this).attr("data-pos",15*($(this).data("page")-1) +i+1);
        else
            $(this).attr("data-pos",i+1);
    });
}

ready = function(){

    // call set_positions function
    set_positions();

    $('.sortable').sortable();

    // after the order changes
    $('.sortable').sortable().bind('sortupdate', function(e, ui) {
        // array to store new order
        updated_order = []
        // set the updated positions
        set_positions();

        // populate the updated_order array with the new task positions
        $('.scard').each(function(i){
            if ($(this).data("page") != '')
                updated_order.push({ id: $(this).data("id"), position:15*($(this).data("page")-1) + i+1 });
            else
                updated_order.push({ id: $(this).data("id"), position:i+1 });
        });

        // send the updated order via ajax
        $.ajax({
            type: "PUT",
            url: '/medals/sort',
            data: { order: updated_order }
        });
    });
}

$(document).ready(ready);
/**
 * if using turbolinks
 */
$(document).on('page:load', ready);
