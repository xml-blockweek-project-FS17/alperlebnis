//https://my.getstarted.com.au/knowledgebase/56/500-Error-File-is-writeable-by-group.html

$(document).ready(function(){
    init();
});

function loadContent($sourcexmlfile, $targetxmlfile, $xsdfile, $xslfile, $action, $params)
{
    var $paramJSON = JSON.stringify($params);

    return $.ajax({
        type: "POST",
        url: '../php/XMLHandler.php',
        async: false,
        data: {sourcexmlfile: $sourcexmlfile, targetxmlfile: $targetxmlfile, xsdfile: $xsdfile, xslfile: $xslfile, action: $action, params: $paramJSON},
        success: function(data){
            //return data;
        }
    }).responseText;
}

function init()
{
    $(".datepicker").datepicker();
    $(".datepicker").datepicker("option", "dateFormat", "yy-mm-dd" );
    $(".datepicker").datepicker('option', {minDate: 0});
    $("#book_startdate").datepicker().datepicker("setDate", new Date());
    $("#showroom").click(function() {
        $startdate = $("#book_startdate").datepicker().val();
        $enddate = $("#book_enddate").datepicker().val();
        if($startdate == '' || $enddate == ''){ return; }
        var data = loadContent('../data/roomdb.xml', '../data/roomdb.xml', '../data/roomdb_schema.xsd', '../pages/freerooms.xsl', 'loadFreeRooms',
            { startdate: $startdate, enddate: $enddate });
        $('#content').empty().append($.parseHTML(data));
        init();
    });
    $(".tabs").tabs({
        activate: function( event, ui ) {
            localStorage.selectedTab = ui.newTab.index() + 1;
        },
        active: localStorage.selectedTab ? localStorage.selectedTab - 1 : 0
    });
    $(".widget input[type=submit], .widget a, .widget button").button();
    $("#addroom").click(function() {
        $roomname = $("#add_roomname").val();
        $roomprice = $("#add_roomprice").val();
        $roombeds = $("#add_roombeds").val();
        $roomimage = $("#add_roomimage").val();
        $roomdescription = $("#add_roomdescription").val();
        if($roomname == '' || $roomprice == '' || $roombeds == '' || $roomimage == '' || $roomdescription == ''){ return; }
        var data = loadContent('../data/roomdb.xml', '../data/roomdb.xml', '../data/roomdb_schema.xsd', '../pages/rooms.xsl', 'writeNewRoom',
            { name: $roomname, price: $roomprice, beds: $roombeds, image: $roomimage, description: $roomdescription });
        alert(data);
        location.href='../pages/admin.xml';
    });
    $(".editroom").click(function() {
        $roomid = $(this).parent().parent().parent().find('table').attr('id');
        $roomimage = $(this).parent().parent().parent().find('.roomitemimage').css('background-image').replace('url(','').replace(')','').replace(/\"/gi, "");
        $roomname = $(this).parent().parent().parent().find('.roomitemname').html();
        $roomprice = $(this).parent().parent().parent().find('.roomitemprice').html();
        $roombeds = $(this).parent().parent().parent().find('.roomitembeds').html();
        $roomdescription = $(this).parent().parent().parent().find('.roomitemdescription').html();
        $('#edit_roomname').val($roomname);
        $('#edit_roomimage').val($roomimage);
        $('#edit_roomprice').val($roomprice);
        $('#edit_roombeds').val($roombeds);
        $('#edit_roomdescription').val($roomdescription);
        $("#editroomdialog").dialog({
            modal: true,
            buttons: {
                Ok: function() {
                    $roomimage = $('#edit_roomimage').val();
                    $roomname = $('#edit_roomname').val();
                    $roomprice = $('#edit_roomprice').val();
                    $roombeds = $('#edit_roombeds').val();
                    $roomdescription = $('#edit_roomdescription').val();
                    if($roomid == '' || $roomimage == '' || $roomname == '' || $roomprice == '' || $roombeds == '' || $roomdescription == ''){ return; }
                    var data = loadContent('../data/roomdb.xml', '../data/roomdb.xml', '../data/roomdb_schema.xsd', '../pages/admin.xsl', 'editRoom',
                        { id: $roomid, name: $roomname, price: $roomprice, beds: $roombeds, image: $roomimage, description: $roomdescription });
                    $( this ).dialog( "close" );
                    alert(data);
                    location.href='../pages/admin.xml'
                },
                Abbrechen: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
    });
    $(".deleteroom").click(function() {
        $roomid = $(this).parent().parent().parent().find('table').attr('id');
        $("#deleteroomdialog").dialog({
            modal: true,
            buttons: {
                Ok: function() {
                    if($roomid == ''){ return; }
                    var data = loadContent('../data/roomdb.xml', '../data/roomdb.xml', '../data/roomdb_schema.xsd', '../pages/rooms.xsl', 'deleteRoom',
                        { id: $roomid });
                    $( this ).dialog( "close" );
                    alert(data);
                    location.href='../pages/admin.xml';
                },
                Abbrechen: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
    });
    $("#addevent").click(function() {
        $eventtitle = $("#add_eventtitle").val();
        $eventprovider = $("#add_eventprovider").val();
        $eventactivitydate = $("#add_eventactivitydate").val();
        $eventdescription = $("#add_eventdescription").val();
        $eventimage = $("#add_eventimage").val();
        $eventcontact_phone = $("#add_eventcontact_phone").val();
        $eventcontact_email = $("#add_eventcontact_email").val();
        $eventprice = $("#add_eventprice").val();
        $eventsignupstart = $("#add_eventsignupstart").val();
        $eventsignupend = $("#add_eventsignupend").val();
        if($eventtitle == '' || $eventprovider == '' || $eventactivitydate == '' || $eventdescription == '' || $eventimage == '' || $eventcontact_phone == '' || $eventcontact_email == '' || $eventprice == '' || $eventsignupstart == '' || $eventsignupend == ''){ return; }
        var data = loadContent('../data/activitydb.xml', '../data/activitydb.xml', '../data/activitydb_schema.xsd', '../pages/activity.xsl', 'writeNewActivity',
            { title: $eventtitle, provider: $eventprovider, activitydate: $eventactivitydate, description: $eventdescription, image: $eventimage,
                contact_phone: $eventcontact_phone, contact_email: $eventcontact_email, price: $eventprice, signupstart: $eventsignupstart, signupend: $eventsignupend });
        alert(data);
        location.href='../pages/admin.xml';
    });
    $(".editevent").click(function() {
        $eventid = $(this).parent().parent().parent().find('table').attr('id');
        $eventtitle = $(this).parent().parent().parent().find('.eventitemtitle').html();
        $eventimage = $(this).parent().parent().parent().find('.eventitemimage').css('background-image').replace('url(','').replace(')','').replace(/\"/gi, "");
        $eventprovider = $(this).parent().parent().parent().find('.eventitemprovider').html();
        $eventprice = $(this).parent().parent().parent().find('.eventitemprice').html();
        $eventactivitydate = $(this).parent().parent().parent().find('.eventitemactivitydate').html();
        $eventsignupstart = $(this).parent().parent().parent().find('.eventitemsignupstart').html();
        $eventsignupend = $(this).parent().parent().parent().find('.eventitemsignupend').html();
        $eventphone = $(this).parent().parent().parent().find('.eventitemphone').html();
        $eventemail = $(this).parent().parent().parent().find('.eventitememail').html();
        $eventdescription = $(this).parent().parent().parent().find('.eventitemdescription').html();
        $('#edit_eventtitle').val($eventtitle);
        $('#edit_eventimage').val($eventimage);
        $('#edit_eventprovider').val($eventprovider);
        $('#edit_eventprice').val($eventprice);
        $('#edit_eventactivitydate').val($eventactivitydate);
        $('#edit_eventsignupstart').val($eventsignupstart);
        $('#edit_eventsignupend').val($eventsignupend);
        $('#edit_eventcontact_phone').val($eventphone);
        $('#edit_eventcontact_email').val($eventemail);
        $('#edit_eventdescription').val($eventdescription);
        $("#editeventdialog").dialog({
            modal: true,
            buttons: {
                Ok: function() {
                   
                    $eventtitle = $('#edit_eventtitle').val();
                    $eventimage = $('#edit_eventimage').val();
                    $eventprovider = $('#edit_eventprovider').val();
                    $eventprice = $('#edit_eventprice').val();
                    $eventactivitydate = $('#edit_eventactivitydate').val();
                    $eventsignupstart = $('#edit_eventsignupstart').val();
                    $eventsignupend = $('#edit_eventsignupend').val();
                    $eventphone = $('#edit_eventcontact_phone').val();
                    $eventemail = $('#edit_eventcontact_email').val();
                    $eventdescription = $('#edit_eventdescription').val();

                    if($eventid == '' || $eventtitle == '' || $eventprovider == '' || $eventactivitydate == '' || $eventdescription == '' || $eventimage == '' || $eventphone == '' || $eventemail == '' || $eventprice == '' || $eventsignupstart == '' || $eventsignupend == ''){ return; }
                    var data = loadContent('../data/activitydb.xml', '../data/activitydb.xml', '../data/activitydb_schema.xsd', '../pages/activity.xsl', 'editEvent',
                        { id: $eventid, title: $eventtitle, provider: $eventprovider, activitydate: $eventactivitydate, description: $eventdescription, image: $eventimage,
                            contact_phone: $eventphone, contact_email: $eventemail, price: $eventprice, signupstart: $eventsignupstart, signupend: $eventsignupend });
                    $( this ).dialog( "close" );
                    alert(data);
                    location.href='../pages/admin.xml';
                },
                Abbrechen: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
    });
    $(".deleteevent").click(function() {
        $eventid =  $(this).parent().parent().parent().find('table').attr('id');
        $("#deleteeventdialog").dialog({
            modal: true,
            buttons: {
                Ok: function() {
                    if($eventid == ''){ return; }
                    var data = loadContent('../data/activitydb.xml', '../data/activitydb.xml', '../data/activitydb_schema.xsd', '../pages/activity.xsl', 'deleteEvent',
                        { id: $eventid });
                    $( this ).dialog( "close" );
                    alert(data);
                    location.href='../pages/admin.xml';
                },
                Abbrechen: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
    });
    $(".bookroom").click(function() {
        $roomid = $(this).parent().parent().parent().find('table').attr('id');
        $("#bookroomdialog").dialog({
            modal: true,
            buttons: {
                Ok: function() {
                    $bookstartdate = $('#book_startdate').val();
                    $bookenddate = $('#book_enddate').val();
                    $bookemail = $('#book_email').val();
                    $booksalutation = $("#book_salutation option:selected").text();
                    $bookfirstname = $('#book_firstname').val();
                    $booklastname = $('#book_lastname').val();
                    $bookaddress = $('#book_address').val();
                    $bookzipcode = $('#book_zipcode').val();
                    $bookstate = $('#book_state').val();
                    $bookcountry = $('#book_country').val();
                    if($roomid == '' || $bookstartdate == '' || $bookenddate == '' || $bookemail == '' || $booksalutation == '' || $bookfirstname == '' || $booklastname == '' || $bookaddress == '' || $bookzipcode == '' || $bookstate == '' || $bookcountry == ''){ return; }
                    var data = loadContent('../data/roomdb.xml', '../data/roomdb.xml', '../data/roomdb_schema.xsd', '../pages/rooms.xsl', 'writeNewBooking',
                        { roomid: $roomid, startdate: $bookstartdate, enddate: $bookenddate, email: $bookemail, salutation: $booksalutation, firstname: $bookfirstname, lastname: $booklastname, address: $bookaddress, zipcode: $bookzipcode, state: $bookstate, country: $bookcountry });
                    $( this ).dialog( "close" );
                    alert(data);
                    window.open('../php/FO/generate-booking.php', '_blank');
                },
                Abbrechen: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
    });
    $(".showbooking").click(function() {
        $roomid = $(this).parent().parent().parent().find('table').attr('id');
        if($roomid == ''){ return; }
        $(".bookingsdialog[roomid="+$roomid+"]").dialog();
    });
    $("#statistics").click(function() {
        location.href='../pages/statistics.xml';
    });
    $("#startDate").datepicker();
    $("#startDate").datepicker("option", "dateFormat", "yy-mm-dd" );
    $("#endDate").datepicker();
    $("#endDate").datepicker("option", "dateFormat", "yy-mm-dd" );
}