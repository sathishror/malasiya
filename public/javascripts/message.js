$().ready(function(){
    
    $("#post_message").live("click", function(){
        if($("#message_user_select").val() == "Sort by")
        {
            alert("Select the User Level");
        }
        else if ($("#msg").val() == "")
        {
            alert("Field should not be empty");
        }
        else if ($("#dept_admin_not_available").val() == 1)
        {
            alert("There is no admin available for the selected department. Please select some other department.");
        }
        else
        {
            if($("#message_user_select").val() == "Select Department"){

                if ($("#std_departments").val() != '')
                {
                    $.get("/messages/post_messages",{
                        agency : $("#std_agency").val(),
                        dept : $("#std_departments").val(),
                        message : $("#msg").val()
                    },
                    function(data){
                        $("#message_section").html(data);
                        alert("Message Posted");
                    });
                }
                else
                {
                    alert("Please Select Department");
                }
            }
            else if($("#message_user_select").val() == "Select Agency")
            {
                if ($("#std_agency").val() != '')
                {
                    $.get("/messages/post_messages",{
                        agency : $("#std_agency").val(),
                        message : $("#msg").val()
                    },
                    function(data){
                        $("#message_section").html(data);
                        alert("Message Posted");
                    });
                }
                else
                {
                    alert("Please Select Agency");
                }
            }
            else if ($("#message_user_select").val() == "All Admins")
            {
                $.get("/messages/post_messages",{
                    all_admins : 1,
                    message : $("#msg").val()
                },
                function(data){
                    $("#message_section").html(data);
                    alert("Message Posted");
                });
            }
            else if ($("#message_user_select").val() == "Select Dept Admin")
            {
                $.get("/messages/post_messages",{
                    dept_admin : 1,
                    department : $("#std_departments").val(),
                    message : $("#msg").val()
                },
                function(data){
                    $("#message_section").html(data);
                    alert("Message Posted");
                });
            }
            else
            {
                $.get("/messages/post_messages",{
                    dept : $("#std_departments").val(),
                    message : $("#msg").val()
                },
                function(data){
                    $("#message_section").html(data);
                    alert("Message Posted");
                });
               
               
            }
        }
    });

    /* Message User Type Select Combo Box */

    $("#message_user_select").live("change", function(){

        if($("#message_user_select").val() == "Select Agency" || $("#message_user_select").val() == "Select Department" || $("#message_user_select").val() == "Select Dept Admin" || $("#message_user_select").val() == "Select Unit" || $("#message_user_select").val() == "Select Unit Admin")
        {
            $.get("/messages/get_agencies",{
                value:$("#message_user_select").val()
            },
            function(data){
                $("#user_type_select_div").show();
                $("#user_type_select_div").html(data);
            });
        }
        else
        {
            $("#user_type_select_div").hide();

        }
    });

    /* Message Agency Type Select Combo Box */

    $("#std_agency").live("change", function(){

        if($("#message_user_select").val() != "Select Agency")
        {
            $.get("/messages/get_departments",{
                value:$("#std_agency").val()
            },
            function(data){
                $("#user_type_select_div").html(data);
            });
        }
    });

    $("#std_departments").live("change", function(){

        if($("#message_user_select").val() == "Select Dept Admin")
        {
            $.get("/messages/get_department_admin",{
                agency:$("#std_agency").val(),
                dept:$("#std_departments").val()
            },
            function(data){
                $("#user_type_select_div").html(data);
            });
        }
        else if($("#message_user_select").val() == "Select Unit" || $("#message_user_select").val() == "Select Unit Admin")
        {
            $.get("/messages/get_units",{
                agency:$("#std_agency").val(),
                dept:$("#std_departments").val()
            },
            function(data){
                $("#user_type_select_div").html(data);
            });
        }

    });

    $("#std_units").live("change",function(){

        if($("#message_user_select").val() == "Select Unit Admin"){
            $.get("/messages/get_unit_admin",{
                agency:$("#std_agency").val(),
                dept:$("#std_departments").val(),
                unit:$("#std_units").val()
            },
            function(data){
                $("#user_type_select_div").html(data);
            });
        }
    });
    

})


function insert_text_field(val){    
    var tbl = document.getElementById("comments_section_"+val);
    s = val.split("_")    
    tbl.innerHTML = '<div class="PM-cmts box"><div class="PM-cmts-post">\n\
                     <p class="formRow">\n\
                     <label for="cmts" class="ui-watermark-label-pass"></label>\n\
                     <textarea class="" name="" rows="" cols="" id= "post_comment_'+s[1]+'"></textarea>  <p>  </div>'+ '<input type="submit" class="btn2 in-btn2" name="Post" value="Post" onclick=submit_post_comment('+s[1]+'); ></div>'
}



function submit_post_comment(val){
    s = $("#post_comment_"+val).val();    
    if (s != ""){
        $.get("/messages/post_comments",{
            id : val,
            msg : s
        },
        function(data){
            $("#post_message_"+val).html(data);
        });
    }
    else
    {
        alert("Enter something");
    }
}

function validateMessageForm(e){    

    if ($("#message_message").val() == ""){
        alert("Looks like you didn't write anything in the message area.");
        return false;
    }
    else if ($("#message_user_select").val() == "Please Select")
    {
        alert("Select User Level");
        return false;
    }
    else if ($("std_agency").val() == "SELECT AN AGENCY"){
        alert("Select Agency Level");
        return false;
    }
    else if ($("std_departments").val() == "SELECT A DEPARTMENT"){
        alert("Select Department Level");
        return false
    }
    else if ($("std_units").val() == "SELECT AN UNIT"){
        alert("Select Unit Level");
        return false
    }
    else
    {
        return true;
    }    
}

  function validate_ict_firewall_requests(){
    if ($("#source1").val() == "" || $("#source2").val() == "" || $("#source3").val() == "" || $("#source4").val() == "" || $("#dest1").val() == "" || $("#dest2").val() == "" || $("#dest3").val() == "" || $("#dest4").val() == "" || $("#ict_facility_service_id").val() == "" || $("#ict_firewall_requested_from_date").val() == "" || $("#ict_firewall_requested_to_date").val() == "" || $("#ict_firewall_justification").val() == "")
    {
      alert("You didn't provide proper details. Please fill all the required fields.");
      return false;
    }
  }


