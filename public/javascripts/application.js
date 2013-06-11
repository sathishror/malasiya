// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//function remove_fields(link) {
//  $(link).previous("input[type=hidden]").value = "1";
//  $(link).up(".fields").hide();
//}
//
//function add_fields(link, association, content) {
//  var new_id = new Date().getTime();
//  var regexp = new RegExp("new_" + association, "g")
//  $(link).up().insert({
//    before: content.replace(regexp, new_id)
//  });
//}
//
function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
//    Post_Current = Post_Current - 1
}
function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
}
function leftNavigation(link_id, div_id)
{
    $("div.leftNav-links ul li div").hide();
    $("div.leftNav-links ul li a").each(function(index) {
        if ($(this).attr("id")!=link_id)
        {
            $(this).removeClass('selected')
        }
    });
    if($("#"+link_id).hasClass('selected'))
    {
        $("#"+link_id).removeClass("selected")
        $("#"+div_id).hide();
    }
    else
    {
        $("#"+link_id).addClass("selected")
        $("#"+div_id).toggle('fast');
    }
//    $("#"+div_id).toggle();
}
//function getDepartmentforAgency(agency_id, department_id)
//{
////    alert("comes to dept")
//}
function  getResourceforSubcategory(category_id, resource_id)
{
    if($("#"+category_id).val()!="")
    {
        $("#lb_resource").text("Resource")
        $.get("/agency_stores/get_resource_ict",{
            sub_category_id : $("#"+category_id).val()
        }, function(data){
            if (data[0]!=null && data[0]!="")
            {
                $('#'+resource_id).find('option').remove().end()
                $('#'+resource_id).append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                for(var i=0; i<data[0].length;i++)
                {
                    $('#'+resource_id).append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.name));
                }
            }
            else
            {
                $('#'+resource_id).find('option').remove().end()
                $("#resource_ict_equipment_booking_agency_store_id").find('option').remove().end()
                alert("Selected sub category has no resource in your Agency")
                $.get("/agency_stores/get_other_resource_ict",{
                    sub_category_id : $("#"+category_id).val()
                }, function(data){
                    //                    alert("comes here in else")
                    if (data[0]!=null && data[0]!="")
                    {
                        $("#lb_resource").text("Other Agency Resource")
                        $('#'+resource_id).find('option').remove().end()
                        $('#'+resource_id).append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                        for(var i=0; i<data[0].length;i++)
                        {
                            $('#'+resource_id).append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.name));
                        }
                    }
                    else
                    {
                        $('#'+resource_id).find('option').remove().end()
                        $("#resource_ict_equipment_booking_agency_store_id").find('option').remove().end()
                        alert("Selected sub category has no resource in any Agency")
                    }
                })
            }
        })
    }
    else{
        $('#'+resource_id).find('option').remove().end()
        $('#'+resource_id).append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
    }
}
function getAgencyforResource(resource_id, agency_id)
{
    if($("#"+resource_id).val()!="")
    {
        $.get("/agency_stores/get_agency_resource",{
            resource_id : $("#"+resource_id).val()
        }, function(data){
            if (data[0]!=null)
            {
                $('#'+agency_id).find('option').remove().end()
                $('#'+agency_id).append($("<option></option>").attr("value","").text("SELECT A EQUIPMENT CATEGORY TYPE"));
                for(var i=0; i<data[0].length;i++)
                {
                    $('#'+agency_id).append($("<option></option>").attr("value",data[0][i].agency_store.id).text(data[0][i].agency_store.serial_no));
                }
            }
        })
    }
    else{
        $('#'+agency_id).find('option').remove().end()
        $('#'+agency_id).append($("<option></option>").attr("value","").text("SELECT A EQUIPMENT CATEGORY TYPE"));
    }
}
$().ready(function(){
    $("#ict_hardware_booking_application_category_group").live('click', function(){
        $("#div_ict_hardware_add_more").show();
    })
    $("#ict_hardware_booking_application_category_individual").live('click', function(){
        $("#div_ict_hardware_add_more").hide();
    })
    if ($("#pr-time"))
    {
        var date = new Date(); // today

        //var times = prayTime.getPrayerTimes(date, 43, -80, -5);
        var times = prayTime.getPrayerTimes(date, 2.20568, 102.25616, +8);
        //var times = prayTime.getPrayerTimes(date, 13.04, 80.17, +5.30);
        var str = '<table id="timetable">';
        str += '<tr><th colspan="2">'+ date.toLocaleDateString()+ '</th></tr>';
        for(var i = 0; i < times.length; i++)
        {
            str += '<tr><td>'+ prayTime.timeNames[i]+ '</td>';
            str += '<td>'+ times[i]+ '</td></tr>';
        }
        str += '</table>';
        $('#pr-time').html(str);
    }
    $(function() {
        if ($("#tabs").length==1)
        {
            $("#tabs").tabs();
        }
        //        $("input").watermark({
        //            placeholder: function() {
        //                return $(".formRow label[for=" + this.id + "]").hide().text();
        //            }
        //        });
        $("input[type='text']").watermark({
            placeholder: function() {
                return $(".formRow label[for=" + this.id + "]").hide().text();
            }
        });
        $("input[type='password']").watermark({
            placeholder: function() {
                return $(".formRow label[for=" + this.id + "]").hide().text();
            }
        });
        $("textarea").watermark({
            placeholder: function() {
                return $(".formRow label[for=" + this.id + "]").hide().text();
            }
        });
    });
    $("#standard_department_id").live("change",function(){
        $.get("/users/",{
            department_id: $("#standard_department_id").val()
        }, function(data){
            $("#department_id").val($("#standard_department_id").val())
            $("#div_ajax").html(data)
        });
    })
    $("#resource_ict_equipment_booking_sub_category_id").live("change",function(){

        getResourceforSubcategory('resource_ict_equipment_booking_sub_category_id', 'resource_ict_equipment_booking_resource_id')
    })
    $("#resource_ict_equipment_booking_resource_id").live("change",function(){
        //alert("resource_ict_equipment_booking_resource_id")
        getAgencyforResource('resource_ict_equipment_booking_resource_id', 'resource_ict_equipment_booking_agency_store_id')
    })
    $("#transfer_department_id").live("change",function(){
        if ( $("#transfer_department_id").val()=="")
        {
            $.get("/department_users/",{
                department_id: $("#transfer_department_id").val()
            }, function(data){
                $("#department_id").val($("#transfer_department_id").val())
                $("#div_ajax").html(data)
            });
        }

    })
    $("#transfer_department").live("click",function(){
        var selected = new Array();
        $('#div_dept_users input:checked').each(function() {
            var text=$(this).attr('id')
            text= text.replace("transfer_users_", "")
            selected.push(text);
        });
        if ($("#transfer_department_id").val()!="")
        {
            if (selected.length==0)
            {
                alert("Select atleast one user to transfer")
            }
            else
            {
                $.post("/department_users/transfer",{
                    department_id: $("#transfer_department_id").val(),
                    users: selected
                }, function(data){
                    if (data && data.to_s!="Error_code1" &&  data.to_s!="Error_code2")
                    {
                        $("#div_ajax").html(data)
                    }
                    else if (data && data.to_s=="Error_code1")
                    {
                        alert("Selected users cannot be transfered")
                    }
                    else if (data && data.to_s=="Error_code2")
                    {
                        alert("Either department or user is not selected")

                    }
                });
            }
        }
        else
        {
            alert("Select A Department")
        }
    })
    $("#default_department_name").live("change", function(){
        $.post("/dashboard/change_default_department",{
            department_id : $("#default_department_name").val()
        }, function(data){
            if (data[0]=="success")
            {
                alert("Now you can view details which are related to this department only")
                $("#img_default_department_user_role").attr("title",data[1])
                $("#lnk_default_department_user_role").attr("title",data[1])
                $("#lnk_default_department_user_role").html(data[1])
                window.location.href="/dashboard"
            }
            else if (data[0]=="error")
            {
                alert("Default department cannot be changed")
            }
        })
    });


    /*Update Department based on agency*/
    $("#users_agency").live("change", function(){
        if($("#users_agency").val()!="")
        {
            $.get("/department_users/get_departments",{
                agency_id : $("#users_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#users_department').find('option').remove().end()
                    $('#users_unit').find('option').remove().end()
                    $('#users_unit').append($("<option></option>").attr("value","").text("SELECT AN UNIT"));
                    $('#users_department').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#users_department').append($("<option></option>").attr("value",data[0][i].department.id).text(data[0][i].department.name));
                    }
                }
            })
        }
        else
        {
            $('#users_department').find('option').remove().end()
            $('#users_unit').find('option').remove().end()
            $('#users_unit').append($("<option></option>").attr("value","").text("SELECT AN UNIT"));
            $('#users_department').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
        }
    });
    /*Update Unit based on  Department*/
    $("#users_department").live("change", function(){
        if($("#users_department").val()!="")
        {
            $.get("/department_users/get_units",{
                department_id : $("#users_department").val()
            }, function(data){
                if (data[0]!="")
                {
                    $("#unit_display").show();
                    $('#users_unit').find('option').remove().end()
                    $('#users_unit').append($("<option></option>").attr("value","").text("SELECT AN UNIT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#users_unit').append($("<option></option>").attr("value",data[0][i].unit.id).text(data[0][i].unit.name));
                    }
                }
                else
                {
                    $("#unit_display").hide();
                }
            })
        }
    });
    /* UNIT Master Screen index page list */
    $("#id_agency").live("change", function(){
        if($("#id_agency").val()!="")
        {
            $.get("/department_users/get_departments",{
                agency_id : $("#id_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#standard1_department_id').find('option').remove().end()
                    $('#standard1_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
                    for(var i=0; i<data[0].length;i++)
                    {

                        $('#standard1_department_id').append($("<option></option>").attr("value",data[0][i].department.id).text(data[0][i].department.name));
                    }
                }
            })
        }
        else
        {

            $('#standard1_department_id').find('option').remove().end()
            $('#standard1_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
            $.get("/units/",{
                department_id: $("#standard1_department_id").val()
            }, function(data){
                $("#department_id").val($("#standard1_department_id").val())
                $("#div_ajax").html(data)
            })
        }
    });
    $("#standard1_department_id").live("change",function(){
        $.get("/units/",{
            department_id: $("#standard1_department_id").val()
        }, function(data){
            $("#department_id").val($("#standard1_department_id").val())
            $("#div_ajax").html(data)
        });
    })

    /* create */
    $("#unit_agency").live("change", function(){
        if($("#unit_agency").val()!="")
        {
            $.get("/department_users/get_departments",{
                agency_id : $("#unit_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#unit_department_id').find('option').remove().end()
                    $('#unit_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#unit_department_id').append($("<option></option>").attr("value",data[0][i].department.id).text(data[0][i].department.name));
                    }
                }
            })
        }
        else{
            $('#unit_department_id').find('option').remove().end()
            $('#unit_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
        }

    });

    /*units Master screen end */
    /* Transfer Department */
    /*Transfer Departmnet Js Starts*/

    $("#from_department_id").live("change",function(){
        if($("#from_department_id").val()!="")
        {
            $.get("/users/transfer/",{
                department_id: $("#from_department_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#transfer_username').find('option').remove().end()
                    $('#transfer_username').append($("<option></option>").attr("value","").text("SELECT AN USER"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#transfer_username').append($("<option></option>").attr("value",data[0][i].user.ic_number).text(data[0][i].user.first_name));
                    }
                }
            })
        }
    });

    $("#to_department_id").live("change",function(){

        $.get("/users/update_transfer/",{
            depart_id: $("#to_department_id").val()
        }, function(data){
            $("#department_id").val($("#to_department_id").val())
            $("#div_ajax").html(data)
        });
    })

    $("#transfer_from_agency").live("change", function(){
        if($("#transfer_from_agency").val()!="")
        {
            $.get("/department_users/get_departments",{
                agency_id : $("#transfer_from_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#from_department_id').find('option').remove().end()
                    $('#from_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#from_department_id').append($("<option></option>").attr("value",data[0][i].department.id).text(data[0][i].department.name));
                    }
                }
            })
        }
        else
        {
            $('#from_department_id').find('option').remove().end()
            $('#transfer_username').find('option').remove().end()
            $('#from_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
            $('#transfer_username').append($("<option></option>").attr("value","").text("SELECT AN USER"));
        }
    });

    $("#transfer_to_agency").live("change", function(){
        if($("#transfer_to_agency").val()!="")
        {
            $.get("/department_users/get_departments",{
                agency_id : $("#transfer_to_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#to_department_id').find('option').remove().end()
                    $('#to_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#to_department_id').append($("<option></option>").attr("value",data[0][i].department.id).text(data[0][i].department.name));
                    }
                }
            })
        }
        else
        {
            $('#to_department_id').find('option').remove().end()
            $('#to_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
        }
    });

    $("#transfer_username").live("change",function(){
        $.get("/users/get_dept_for_users/",{
            ic_number: $("#transfer_username").val()
        }, function(data){
            if(data[0]!=null)
            {
                $("#user_id").val($("#transfer_username").val())
                var content="<table><tr><td><u><b>List of Existing Departments :</b></u></td></tr><tr><td><br/></td></tr>";
                content+=""
                for(i=0; i<data[0].length; i++)
                {
                    content+="<tr><td><font color='#369'><b>"+data[0][i]+"</b></font></td></tr>"
                }
                content+="</table>"
                $("#div_dept_transfer").html(content)
            }
            else
            {
                content+="No Departments Found"
                $("#div_dept_transfer").html(content)
            }

        });
    })


    /*Transfer Departmnet Js Ends*/



    /* Transfer ends here */
    /* User list left navigation link */
    $("#user_list_department_id").live("change",function(){
        $.get("/departments/depart_user_list/",{
            department_id: $("#user_list_department_id").val()
        }, function(data){
            $("#department_id").val($("#user_list_department_id").val())
            $("#div_ajax").html(data)
        });
    })
    /* Assign Depart starts*/
    $("#standard_user_id").live("change",function(){
        $.get("/department_users/get_departments_for_user/",{
            user_id: $("#standard_user_id").val()
        }, function(data){
            if(data[0]!=null)
            {
                $("#user_id").val($("#standard_user_id").val())
                var content="<table><tr><td><u><b>List of Existing Departments :</b></u></td></tr><tr><td><br/></td></tr>";
                content+=""
                for(i=0; i<data[0].length; i++)
                {
                    content+="<tr><td>"+data[0][i]+"</td></tr>"
                }
                content+="</table>"
                $("#div_dept_name").html(content)
            }
            else
            {
                content+="No Departments Found"
                $("#div_dept_name").html(content)
            }

        });
    })
    $("#assign_department_id").live("change",function(){
        $.post("/users/update_assign/",{
            department_id: $("#assign_department_id").val()
        }, function(data){
            $("#department_id").val($("#assign_department_id").val())
            $("#depart_name").html(data)
        });
    })
    /* Assign Depart ends*/
    $("#standard4_department_id").live("change",function(){
        $.get("/users/",{
            department_id: $("#standard4_department_id").val()
        }, function(data){
            $("#department_id").val($("#standard4_department_id").val())
            $("#div_ajax").html(data)
        });
    })

    /* Chat - List of Users */

    $("#standard5_department_id").live("change",function(){
        $.get("/conversations/",{
            department_id: $("#standard5_department_id").val()
        }, function(data){
            $("#department_id").val($("#standard5_department_id").val())
            $("#div_ajax").html(data)
        });
    })


    $("#standard4_department_id").live("change", function(){
        if($("#standard4_department_id").val()!="")
        {
            $.get("/department_users/get_units_for_transfer",{
                department_id : $("#standard4_department_id").val()
            }, function(data){
                if (data[0] != "")
                {
                    $("#unit_from_hide").show();
                    $('#users_id_unit').find('option').remove().end()
                    $('#users_id_unit').append($("<option></option>").attr("value","").text("SELECT AN UNIT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#users_id_unit').append($("<option></option>").attr("value",data[0][i].unit.id).text(data[0][i].unit.name));
                    }
                }
                else
                {
                    $("#unit_from_hide").hide();
                }
            })
        }
    });

    $("#users_id_unit").live("change",function(){
        $.get("/users/",{
            unit_id: $("#users_id_unit").val()
        }, function(data){
            $("#department_id").val($("#users_id_unit").val())
            $("#div_ajax").html(data)
        });
    })


    /* Dept list page select box */
    $("#agency_list_depart").live("change",function(){
        $.get("/departments/",{
            agency_id: $("#agency_list_depart").val()
        }, function(data){
            $("#department_id").val($("#agency_list_depart").val())
            $("#div_ajax").html(data)
        });
    })

    $("#admin_user_department_id").live("change",function(){
        $.get("/users/admin",{
            department_id: $("#admin_user_department_id").val()
        }, function(data){
            $("#department_id").val($("#admin_user_department_id").val())
            $("#div_ajax").html(data)
        });
    })
    /* User List based on Depart & Agency Starts */
    $("#transfer_agency").live("change", function(){
        if($("#transfer_agency").val()!="")
        {
            $.get("/department_users/get_departments",{
                agency_id : $("#transfer_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#standard4_department_id').find('option').remove().end()
                    $('#standard4_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#standard4_department_id').append($("<option></option>").attr("value",data[0][i].department.id).text(data[0][i].department.name));
                    }
                }
            })
        }
        else
        {
            $('#standard4_department_id').find('option').remove().end()
            $('#standard4_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
            $.get("/users/",{
                department_id: $("#standard4_department_id").val()
            }, function(data){
                $("#department_id").val($("#standard4_department_id").val())
                $("#div_ajax").html(data)
            })
        }
    });
    /* User List based on Depart & Agency Ends */
    /* For create user form validation */
    $("#sub_user_link").live("click",function(){
        if ($("#user_first_name").val() == ""){
            alert("Please Enter First Name");
            return false;
        }
        else if ($("#user_last_name").val() == ""){
            alert("Please Enter Last Name");
            return false;
        }
        else if ($("#user_email").val() == ""){
            alert("Please Enter Email");
            return false;
        }
        else if ($("#num1").val() == ""){
            alert("Enter Ic Number in Box1");
            return false;
        }
        else if ($("#num1").val().length != "6"){
            alert("Enter 6 digits in box1");
            return false;
        }
        else if ($("#num2").val() == ""){
            alert("Enter Ic Number in Box2");
            return false;
        }
        else if ($("#num2").val().length != "2"){
            alert("Enter 2 digits in box2");
            return false;
        }
        else if ($("#num3").val() == ""){
            alert("Enter Ic Number in Box3");
            return false;
        }
        else if ($("#num3").val().length != "4"){
            alert("Enter 4 digits in box3");
            return false;
        }
        else if ($("#user_username").val() == ""){
            alert("Please Enter Display Name");
            return false;
        }
        else if ($("#user_state").val() == ""){
            alert("Please Enter State");
            return false;
        }
        else if ($("#role_id").val() == ""){
            alert("Please Choose Role Value");
            return false;
        }
        else if ($("#users_agency").val() == ""){
            alert("Please Choose Agency Value" );
            return false;
        }
        else if ($("#users_agency_id").val() == ""){
            alert("Please Choose Agency Value" );
            return false;
        }
        else if ($("#users_department").val() == ""){
            alert("Please Choose Department Name");
            return false;
        }

    //        if ($("#users_unit").val() == true){
    //            if ($("#users_unit").val() == ""){
    //                alert("Please Choose Unit Name");
    //                return false;
    //            }
    //        }
    });
    /*user validation ends */

    /*Department basen on Agency in Resource Booking page*/
    $("#users_agency").live("change", function(){
        if($("#users_agency").val()!="")
        {
            $.get("/department_users/get_departments",{
                agency_id : $("#users_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#resource_category_department_id').find('option').remove().end()
                    $('#resource_category_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#resource_category_department_id').append($("<option></option>").attr("value",data[0][i].department.id).text(data[0][i].department.name));
                    }
                }
            })
        }
    });
    $("#department_submit").live("click",function(){
        if ($("#department_agency_id").val() == "")
        {
            alert("Please select an agency");
            return false;
        }
        else if($("#department_name").val()== "")
        {
            alert("Please Enter the Department Name");
            return false;
        }
    });


    $("#resource_category_id").live("change", function(){
        if($("#resource_category_id").val()!="")
        {
            $.get("/resources/get_subcategory",{
                agency_id : $("#resource_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#resource_sub_category_id').find('option').remove().end()
                    $('#resource_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#resource_sub_category_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#resource_sub_category_id').find('option').remove().end()
            $('#resource_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
        }

    });

    /*Transfer Unit Fn Starts*/
    $("#users_unit").live("change",function(){
        if($("#users_unit").val()!="")
        {
            $.get("/users/transfer/",{
                unit_id: $("#users_unit").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#transfer_unit_username').find('option').remove().end()
                    $('#transfer_unit_username').append($("<option></option>").attr("value","").text("SELECT AN USER"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#transfer_unit_username').append($("<option></option>").attr("value",data[0][i].user.ic_number).text(data[0][i].user.first_name));
                    }
                }
            })
        }
    });



    $("#transfer_unit_username").live("change",function(){
        $.get("/users/transfer_unit/",{
            ic_number: $("#transfer_unit_username").val()
        }, function(data){
            if(data[0]!=null)
            {
                $("#user_id").val($("#transfer_unit_username").val())
                var content="<table><tr><td><u><b>List of Existing Units :</b></u></td></tr><tr><td><br/></td></tr>";
                content+=""
                for(i=0; i<data[0].length; i++)
                {
                    content+="<tr><td><font color='#369'><b>"+data[0][i]+"</b></font></td></tr>"
                }
                content+="</table>"
                $("#div_unit_transfer").html(content)
            }
            else
            {
                content+="No Departments Found"
                $("#div_unit_transfer").html(content)
            }

        });
    })
    /*Transfer Unit Fn Ends*/
    /* Dated Oct 31 transfer unit starts*/

    $("#from_department_id").live("change", function(){
        if($("#from_department_id").val()!="")
        {
            $.get("/department_users/get_units_for_transfer",{
                department_id : $("#from_department_id").val()
            }, function(data){
                if (data[0] != null)
                {
                    $('#users_unit').find('option').remove().end()
                    $('#users_unit').append($("<option></option>").attr("value","").text("SELECT AN UNIT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#users_unit').append($("<option></option>").attr("value",data[0][i].unit.id).text(data[0][i].unit.name));
                    }
                }
            })
        }
    });

    $("#to_department_id").live("change", function(){
        if($("#to_department_id").val()!="")
        {
            $.get("/department_users/get_units_for_transfer",{
                department_id : $("#to_department_id").val()
            }, function(data){
                if (data[0]!= null)
                {
                    $('#to_unit_id').find('option').remove().end()
                    $('#to_unit_id').append($("<option></option>").attr("value","").text("SELECT AN UNIT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#to_unit_id').append($("<option></option>").attr("value",data[0][i].unit.id).text(data[0][i].unit.name));
                    }
                }
            })
        }
    });


    $("#users_unit").live("change",function(){
        if($("#users_unit").val()!="")
        {
            $.get("/users/transfer/",{
                unit_id: $("#users_unit").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#transfer_username').find('option').remove().end()
                    $('#transfer_username').append($("<option></option>").attr("value","").text("SELECT AN USER"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#transfer_username').append($("<option></option>").attr("value",data[0][i].user.ic_number).text(data[0][i].user.first_name));
                    }
                }
            })
        }
    });
    /* Dated Oct 31 transfer unit ends*/




    $("#agency_store_agency_id").live("change", function(){
        if($("#agency_store_agency_id").val()!="")
        {
            $.get("/agency_stores/get_resource",{
                agency_id : $("#agency_store_agency_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#resource_resource_id').find('option').remove().end()
                    $('#resource_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#resource_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.name));
                    }
                }
            })
        }
        else{
            $('#resource_resource_id').find('option').remove().end()
            $('#resource_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }

    });


    $("#from_department_id").live("change", function(){
        if($("#from_department_id").val()!="")
        {
            $.get("/agency_stores/get_categories",{
                agency_id : $("#from_department_id").val()
            }, function(data){
                if (data[0]!=null)
                {

                    $('#categories_department_id').find('option').remove().end()
                    $('#categories_department_id').append($("<option></option>").attr("value","").text("SELECT A CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#categories_department_id').append($("<option></option>").attr("value",data[0][i].category.id).text(data[0][i].category.name));
                    }
                }
            })
        }
        else{
            $('#categories_department_id').find('option').remove().end()
            $('#categories_department_id').append($("<option></option>").attr("value","").text("SELECT A CATEGORY"));
        }

    });

    $("#categories_department_id").live("change", function(){
        if($("#categories_department_id").val()!="")
        {
            $.get("/agency_stores/get_sub_categories",{
                agency_id : $("#categories_department_id").val()
            }, function(data){
                if (data[0]!=null)
                {

                    $('#sub_categories_id').find('option').remove().end()
                    $('#sub_categories_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#sub_categories_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#sub_categories_id').find('option').remove().end()
            $('#sub_categories_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }

    });

    $("#sub_categories_id").live("change", function(){
        if($("#sub_categories_id").val()!="")
        {
            $.get("/agency_stores/get_resource",{
                agency_id : $("#sub_categories_id").val()
            }, function(data){
                if (data[0]!=null)
                {

                    $('#resource_resource_id').find('option').remove().end()
                    $('#resource_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#resource_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.name));
                    }
                }
            })
        }
        else{
            $('#resource_resource_id').find('option').remove().end()
            $('#resource_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }

    });

    /*Validation for Agency Store Starts*/
    $("#agency_store_submit").live("click",function(){
        if ($("#transfer_from_agency").val() == ""){
            alert("Select Agency value");
            return false;
        }
        else if ($("#from_department_id").val() == ""){
            alert("Select Department value");
            return false;
        }
        else if ($("#categories_department_id").val() == ""){
            alert("Select Category");
            return false;
        }
        else if ($("#sub_categories_id").val() == ""){
            alert("Select Sub Cateogory");
            return false;
        }
        else if ($("#resource_resource_id").val() == ""){
            alert("Select Resource");
            return false;
        }

    });
    /*Validation for Agency Store Ends*/

    $("#category_id").live("change", function(){
        if($("#category_id").val()!="")
        {
            $.get("/sub_categories/get_sub_categories",{
                category_id : $("#category_id").val()
            }, function(data){
                if (data[0]!=null)
                {

                    $('#sub_category_id').find('option').remove().end()
                    $('#sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#sub_category_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#sub_category_id').find('option').remove().end()
            $('#sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
        }
    })

    $("#sub_category_id").live("change", function(){
        if($("#sub_category_id").val()!="")
        {
            $.get("/resources/get_resources",{
                sub_category_id : $("#sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {

                    $('#agency_store_resource_id').find('option').remove().end()
                    $('#agency_store_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#agency_store_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#sub_category_id').find('option').remove().end()
            $('#sub_category_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })
    /* drop down others resource booking */
    $("#category_id").live("change", function(){
        if($("#category_id").val()!="")
        {
            $.get("/sub_categories/get_sub_categories",{
                category_id : $("#category_id").val()
            }, function(data){
                if (data[0]!=null)
                {

                    $('#sub_category_id').find('option').remove().end()
                    $('#sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#sub_category_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#sub_category_id').find('option').remove().end()
            $('#sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
        }
    })

    $("#sub_category_id").live("change", function(){
        if($("#sub_category_id").val()!="")
        {
            $.get("/resources/get_resources",{
                sub_category_id : $("#sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {

                    $('#agency_store_resource_id').find('option').remove().end()
                    $('#agency_store_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#agency_store_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#sub_category_id').find('option').remove().end()
            $('#sub_category_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })
    /* resource booking ends here */
    /*Validation for Category Mapping Starts*/
    $("#user_submit").live("click",function(){
        if (($("#users_agency").val() == "") || ($("#users_agency_id").val() == "")) {
            alert("Select Agency value");
            return false;
        }
        else if ($("#resource_category_department_id").val() == ""){
            alert("Select Department value");
            return false;
        }
        else if ($("#resource_category_resource_category_id").val() == ""){
            alert("Select Category value");
            return false;
        }
    });
    /*Validation for Category Mapping Ends*/

    $("#categories_id").live("change",function(){
        $.get("/sub_categories/",{
            category_id: $("#categories_id").val()
        }, function(data){
            $("#department_id").val($("#categories_id").val())
            $("#div_ajax").html(data)
        });
    })



    /* adding dynamic text box in agency store fomr */
    //    var i = $('input').size() + 1;
    var i = 0 + 1;
    $('#add').click(function() {
        $('<div class="form-sec-row"><label class="text">Serial No '+i+'</label></div><div class="form-sec-row-center"><input type="text" class="field" size=29  name="dynamic[' + i + ']" /></div>').fadeIn('slow').appendTo('.inputs');
        i++;
    });
    //<input type="text" class="field" size=30 name="dynamic[]" value="' + i + '" />
    $('#remove').click(function() {
        if(i > 1) {
            $('.field:last').remove();
            i--;
        }
    });

    $('#reset').click(function() {
        while(i > 2) {
            $('.field:last').remove();
            i--;
        }
    });


    // here's our click function for when the forms submitted

    //    $('.submit').click(function(){
    //
    //
    //        var answers = [];
    //        $.each($('.field'), function() {
    //            answers.push($(this).val());
    //        });
    //
    //        if(answers.length == 0) {
    //            answers = "none";
    //        }
    //
    //        alert(answers);
    //
    //        return false;
    //
    //    });
    /* dynamic text box ends */
    /* category mapping list page will show based on dept selection */
    $("#cat_department_id").live("change",function(){
        $.get("/categories/list_category_mapping/",{
            category_id: $("#cat_department_id").val()
        }, function(data){
            $("#department_id").val($("#cat_department_id").val())
            $("#div_ajax").html(data)
        });
    })
    /* category mapping list ends */

    $("#default_department_id").live("change",function(){
        $.get("/dashboard/def_dept",{
            department_id: $("#default_department_id").val()
        }, function(data){
            $("#department_id").val($("#default_department_id").val())
            $("#div_ajax").html(data)
        });
    })
    /*Assign Resource Manager Validation Starts*/
    $("#agency_submit").live("click",function(){
        if ($("#transfer_from_agency").val() == ""){
            alert("Select Agency value");
            return false;
        }
        else if ($("#from_department_id").val() == ""){
            alert("Select Department");
            return false;
        }
        else if ($("#transfer_username").val() == ""){
            alert("Select User");
            return false;
        }
    });
    /*Assign Resource Manager Validation Ends*/
    // $("#resource_resource_type_room_booking").live("change",function(){
    //        $.get("/resources/get_resource_type",{
    //            department_id: $("#resource_resource_type_room_booking").val()
    //        }, function(data){
    //            $("#department_id").val($("#resource_resource_type_room_booking").val())
    //            $("#div_ajax").html(data)
    //        });
    //    })
    //    $("#agency_store_resource_type_others").live("change",function(){
    //         if($("#agency_store_resource_type_others").val()!="")
    //        $.get("/agency_stores/get_others",{
    //            department_id: $("#agency_store_resource_type_others").val()
    //        }, function(data){
    //            $("#department_id").val($("#agency_store_resource_type_others").val())
    //            $("#div_others").html(data)
    //        });
    //        else{
    //            $('#agency_store_resource_type_others').append()
    //
    //        }
    //    })
    //     $("#agency_store_resource_type_room_booking").live("change",function(){
    //        $.get("/agency_stores/get_booking",{
    //            department_id: $("#agency_store_resource_type_room_booking").val()
    //        }, function(data){
    //            $("#department_id").val($("#agency_store_resource_type_room_booking").val())
    //            $("#div_booking").html(data)
    //        });
    //    })
    //     $("#agency_store_resource_type_transport").live("change",function(){
    //        $.get("/agency_stores/get_transport",{
    //            department_id: $("#agency_store_resource_type_transport").val()
    //        }, function(data){
    //            $("#department_id").val($("#agency_store_resource_type_transport").val())
    //            $("#div_transport").html(data)
    //        });
    //    })
    //    $("#agency_store_resource_type_ict").live("change",function(){
    //        $.get("/agency_stores/get_ict",{
    //            department_id: $("#agency_store_resource_type_ict").val()
    //        }, function(data){
    //            $("#department_id").val($("#agency_store_resource_type_ict").val())
    //            $("#div_ict").html(data)
    //        });
    //    })

    $("#vehicle_type_id").live("change", function(){
        if($("#vehicle_type_id").val()!="")
        {
            $.get("/agency_stores/get_vehicles",{
                vehicle_id : $("#vehicle_type_id").val()
            }, function(data){
                if (data[0]!=null)
                {

                    $('#vehicle_id').find('option').remove().end()
                    $('#vehicle_id').append($("<option></option>").attr("value","").text("SELECT A VEHICLE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#vehicle_id').append($("<option></option>").attr("value",data[0][i].vehicle.id).text(data[0][i].vehicle.registration_number));
                    }
                }
            })
        }
        else{
            $('#vehicle_id').find('option').remove().end()
            $('#vehicle_id').append($("<option></option>").attr("value","").text("SELECT A VEHICLE"));
        }
    })

    $("#resource_room_booking_room_type_id").live("change",function(){
        if($("#resource_room_booking_room_type_id").val()!="")
        {
            $.get("/resource_room_bookings/get_list_of_facility",{
                room_id : $("#resource_room_booking_room_type_id").val()
            }, function(data){
                if (data[0] != "")
                {
                    $("#list_facility").show();
                    var content="<table><tr><td><font color='#BB0802'><u><b>List of Facility :</b></font></u></td></tr><tr><td></td></tr>";
                    content+=""
                    for(i=0; i<data[0].length; i++)
                    {
                        content+="<tr><td><font color='#BB0802'><b>"+data[0][i].facility.name+"-"+data[0][i].facility.total_qty+"</b></font></td></tr>"
                    }
                    content+="</table>"
                    $("#list_facility").html(content)
                }
                else
                {
                    $("#list_facility").hide();
                }
            })
        }
    });
    $("#resource_resource_type_ict").live("click",function(){
        $("#show_ict").show();
        $("#show_transport").hide();
        $("#show_room").hide();
        $("#show_others").hide();
    });

    $("#resource_resource_type_room_booking").live("click",function(){
        $("#show_room").show();
        $("#show_ict").hide();
        $("#show_transport").hide();
        $("#show_others").hide();
    });
    $("#resource_resource_type_transport").live("click",function(){
        $("#show_transport").show();
        $("#show_ict").hide();
        $("#show_room").hide();
        $("#show_others").hide();
    });
    $("#resource_resource_type_others").live("click",function(){
        $("#show_others").show();
        $("#show_ict").hide();
        $("#show_transport").hide();
        $("#show_room").hide();
    });

    $("#agency_store_resource_type_others").live("click",function(){
        $("#agency_others").show();
        $("#agency_transport").hide();
        $("#agency_room").hide();
        $("#agency_ict").hide();
    });
    $("#agency_store_resource_type_room_booking").live("click",function(){
        $("#agency_room").show();
        $("#agency_others").hide();
        $("#agency_transport").hide();
        $("#agency_ict").hide();
    });
    $("#agency_store_resource_type_transport").live("click",function(){
        $("#agency_transport").show();
        $("#agency_others").hide();
        $("#agency_room").hide();
        $("#agency_ict").hide();
    });
    $("#agency_store_resource_type_ict").live("click",function(){
        $("#agency_ict").show();
        $("#agency_others").hide();
        $("#agency_transport").hide();
        $("#agency_room").hide();
    });

    /* create resource  page drop down for others and transport */
    $("#resource_other_category_id").live("change", function(){
        if($("#resource_other_category_id").val()!="")
        {
            $.get("/resources/get_subcategory",{
                agency_id : $("#resource_other_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#resource_other_sub_category_id').find('option').remove().end()
                    $('#resource_other_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#resource_other_sub_category_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#resource_other_sub_category_id').find('option').remove().end()
            $('#resource_other_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
        }

    });

    $("#resource_transport_category_id").live("change", function(){
        if($("#resource_transport_category_id").val()!="")
        {
            $.get("/resources/get_subcategory",{
                agency_id : $("#resource_transport_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#resource_transport_sub_category_id').find('option').remove().end()
                    $('#resource_transport_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#resource_transport_sub_category_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#resource_transport_sub_category_id').find('option').remove().end()
            $('#resource_transport_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
        }

    });
    /* resource drop box ends */





    $("#vehicle_id").live("change",function(){

        if($("#vehicle_id").val() != "SELECT A VEHICLE"){
            $.get("/resource_transportation_bookings/get_driver_details",{
                id : $("#vehicle_id").val()
            },
            function(data){
                $("#driver_details").html(data);
            });
        }
    });


    /* Chat Apps Code */

    $("#btn3").live("click",function(){
        if ($("#content").val() == ""){
            alert("Message shouldn't be blank...");
            $("#content").focus();
            return false;
        }
        else
        {
            //            alert("Message sent...");
            $.ajax({
                complete: function(){
                    $('#chat-msg').load('/conversations/'+jsUserID);
                // Handle the complete event
                }
            // ......
            });

        }
    });

    /* resource room booking script */
    $("#resource_room_booking_sub_category_id").live("change", function(){
        if($("#resource_room_booking_sub_category_id").val()!="")
        {
            $.get("/resource_room_bookings/get_resources",{
                sub_category_id : $("#resource_room_booking_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#resource_room_booking_resource_id').find('option').remove().end()
                    $('#resource_room_booking_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#resource_room_booking_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#resource_room_booking_resource_id').find('option').remove().end()
            $('#resource_room_booking_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })


    $("#resource_room_booking_resource_id").live("click",function(){
        $.get("/resource_room_bookings/get_details_for_resource/",{
            resource_id: $("#resource_room_booking_resource_id").val()
        }, function(data){
            if(data[0]!=null)
            {
                $("#dis_col").show();
                $("#details_resource_id").show();
                var content="";
                content+=""
                content+= "<tr><td><b>Location</b></td><td><font color='#369'><b>"+data[0].resource.location+"</b></font></td></tr>"
                content+= "<tr><td><b>Capacity</b></td><td><font color='#369'><b>"+data[0].resource.capacity+"</b></font></td></tr>"
                content+="</table>"
                $("#details_resource_id").html(content)
            }
            else
            {
                content+="No Departments Found"
                $("#details_resource_id").hide();
                $("#details_resource_id").html(content)
                $("#dis_col").hide();
            }

        });
    })
    /*room booking script ends */

    /* faclity page */
    $("#facility_resource_type_room_booking").live("click",function(){
        $("#room_facility").show();
        $("#transport_facility").hide();
        $("#other_facility").hide();
        $("#sub_list_facility").show();
    });

    $("#facility_resource_type_transport").live("click",function(){
        $("#room_facility").hide();
        $("#transport_facility").show();
        $("#other_facility").hide();
        $("#sub_list_facility").show();
    });

    $("#facility_resource_type_others").live("click",function(){
        $("#room_facility").hide();
        $("#transport_facility").hide();
        $("#other_facility").show();
        $("#sub_list_facility").show();
    });


    $("#room_sub_category_id").live("change", function(){
        if($("#room_sub_category_id").val()!="")
        {
            $.get("/resource_room_bookings/get_resources",{
                sub_category_id : $("#room_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#room_resource_id').find('option').remove().end()
                    $('#room_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#room_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#room_resource_id').find('option').remove().end()
            $('#room_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })


    $("#transport_sub_category_id").live("change", function(){
        if($("#transport_sub_category_id").val()!="")
        {
            $.get("/resource_room_bookings/get_resources",{
                sub_category_id : $("#transport_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#transport_resource_id').find('option').remove().end()
                    $('#transport_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#transport_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#transport_resource_id').find('option').remove().end()
            $('#transport_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })

    $("#other_sub_category_id").live("change", function(){
        if($("#other_sub_category_id").val()!="")
        {
            $.get("/resource_room_bookings/get_resources",{
                sub_category_id : $("#other_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#other_resource_id').find('option').remove().end()
                    $('#other_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#other_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#other_resource_id').find('option').remove().end()
            $('#other_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })
    $("#resource_room_booking_resource_id").live("change",function(){
        if($("#resource_room_booking_resource_id").val()!="")
        {
            $.get("/resource_room_bookings/get_list_of_facility",{
                resource_id : $("#resource_room_booking_resource_id").val()
            }, function(data){
                if (data[0] != "")
                {
                    $("#list_facility").show();
                    var content="<table><tr><td><font color='#BB0802'><u><b>List of Facility :</b></font></u></td></tr><tr><td></td></tr>";
                    content+=""
                    for(i=0; i<data[0].length; i++)
                    {
                        content+="<tr><td><font color='#BB0802'><b>"+data[0][i].facility.name+"-"+data[0][i].facility.total_qty+"</b></font></td></tr>"
                    }
                    content+="</table>"
                    $("#list_facility").html(content)
                }
                else
                {
                    $("#list_facility").hide();
                }
            })
        }
    });
    /* facility ends */
    /* Chat User List based on Depart & Agency Starts */
    $("#transfer_agency").live("change", function(){
        if($("#transfer_agency").val()!="")
        {
            $.get("/department_users/get_departments",{
                agency_id : $("#transfer_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#standard5_department_id').find('option').remove().end()
                    $('#standard5_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#standard5_department_id').append($("<option></option>").attr("value",data[0][i].department.id).text(data[0][i].department.name));
                    }
                }
            })
        }
        else
        {
            $('#standard5_department_id').find('option').remove().end()
            $('#standard5_department_id').append($("<option></option>").attr("value","").text("SELECT A DEPARTMENT"));
            $.get("/conversations/",{
                department_id: $("#standard5_department_id").val()
            }, function(data){
                $("#department_id").val($("#standard5_department_id").val())
                $("#div_ajax").html(data)
            })
        }
    });
    /* chat user ends*/
    /* resource room booking validation */
    $("#resource_room_booking_submit").live("click",function(){
        if ($("#resource_room_booking_sub_category_id").val() == ""){
            alert("Select Sub Category value");
            return false;
        }
        else if ($("#resource_room_booking_resource_id").val() == ""){
            alert("Select Resource value");
            return false;
        }
        else if ($("#resource_room_booking_requested_from_date").val() == ""){
            alert("Enter From date");
            return false;
        }else if ($("#resource_room_booking_requested_to_date").val() == ""){
            alert("Enter To date");
            return false;
        }else if ($("#resource_room_booking_room_capacity").val() == ""){
            alert("Enter Room Capacity");
            return false;
        }else if ($("#resource_room_booking_purpose").val() == ""){
            alert("Enter Purpose");
            return false;
        }
    });

    /*Agenct store drop box starts*/
    $("#room_agency_sub_category_id").live("change", function(){
        if($("#room_agency_sub_category_id").val()!="")
        {
            $.get("/resource_room_bookings/get_resources",{
                sub_category_id : $("#room_agency_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#room_agency_resource_id').find('option').remove().end()
                    $('#room_agency_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#room_agency_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#room_agency_resource_id').find('option').remove().end()
            $('#room_agency_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })


    $("#transport_agency_sub_category_id").live("change", function(){
        if($("#transport_agency_sub_category_id").val()!="")
        {
            $.get("/resource_room_bookings/get_resources",{
                sub_category_id : $("#transport_agency_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#transport_agency_resource_id').find('option').remove().end()
                    $('#transport_agency_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#transport_agency_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#transport_agency_resource_id').find('option').remove().end()
            $('#transport_agency_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })


    $("#other_category_id").live("change", function(){
        if($("#other_category_id").val()!="")
        {
            $.get("/agency_stores/get_other_sub_categories",{
                agency_id : $("#other_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#other_agency_sub_category_id').find('option').remove().end()
                    $('#other_agency_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#other_agency_sub_category_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#other_agency_sub_category_id').find('option').remove().end()
            $('#other_agency_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
        }
    })


    $("#other_agency_sub_category_id").live("change", function(){
        if($("#other_agency_sub_category_id").val()!="")
        {
            $.get("/resource_room_bookings/get_resources",{
                sub_category_id : $("#other_agency_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#other_agency_resource_id').find('option').remove().end()
                    $('#other_agency_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#other_agency_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#other_agency_resource_id').find('option').remove().end()
            $('#other_agency_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })
    $("#ict_agency_sub_category_id").live("change", function(){
        //        getResourceforSubcategory('ict_agency_sub_category_id', 'ict_agency_resource_id')
        if($("#ict_agency_sub_category_id").val()!="")
        {
            $.get("/agency_stores/get_resource_ict",{
                sub_category_id : $("#ict_agency_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#ict_agency_resource_id').find('option').remove().end()
                    $('#ict_agency_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#ict_agency_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.name));
                    }
                }
            })
        }
        else{
            $('#ict_agency_resource_id').find('option').remove().end()
            $('#ict_agency_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })

    /*Agenct store drop box ends*/
    /* resource booking for others */
    $("#other_booking_category_id").live("change", function(){
        if($("#other_booking_category_id").val()!="")
        {
            $.get("/resource_bookings/get_other_sub_categories",{
                category_id : $("#other_booking_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#other_booking_sub_category_id').find('option').remove().end()
                    $('#other_booking_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#other_booking_sub_category_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#other_booking_sub_category_id').find('option').remove().end()
            $('#other_booking_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
        }
    })


    $("#other_booking_sub_category_id").live("change", function(){
        if($("#other_booking_sub_category_id").val()!="")
        {
            $.get("/resource_bookings/get_resources",{
                sub_category_id : $("#other_booking_sub_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#resource_booking_resource_id').find('option').remove().end()
                    $('#resource_booking_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#resource_booking_resource_id').append($("<option></option>").attr("value",data[0][i].resource.id).text(data[0][i].resource.resource_no));
                    }
                }
            })
        }
        else{
            $('#resource_booking_resource_id').find('option').remove().end()
            $('#resource_booking_resource_id').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })
    /* resource booking others ends */
    $("#transport_category_id").live("change", function(){
        if($("#transport_category_id").val()!="")
        {
            $.get("/resources/get_sub_category",{
                sub_category_id : $("#transport_category_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#transport_sub_category_id').find('option').remove().end()
                    $('#transport_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#transport_sub_category_id').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#transport_sub_category_id').find('option').remove().end()
            $('#transport_sub_category_id').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
        }
    })

    $("#transport_sub_category_id").live("change",function(){
        $.get("/resources/",{
            department_id: $("#transport_sub_category_id").val()
        }, function(data){
            $("#department_id").val($("#transport_sub_category_id").val())
            $("#div_ajax").html(data)
        });
    })
    /* agency list page */
    $("#list_agency").live("change", function(){
        if($("#list_agency").val()!="")
        {
            $.get("/agency_stores/get_resources",{
                resource_id : $("#list_agency").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#category_allid').find('option').remove().end()
                    $('#category_allid').append($("<option></option>").attr("value","").text("SELECT A SUB CATEGORY"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#category_allid').append($("<option></option>").attr("value",data[0][i].sub_category.id).text(data[0][i].sub_category.name));
                    }
                }
            })
        }
        else{
            $('#category_allid').find('option').remove().end()
            $('#category_allid').append($("<option></option>").attr("value","").text("SELECT A RESOURCE"));
        }
    })
    $("#list_agency").live("change",function(){
        $.get("/agency_stores/",{
            resource_id: $("#list_agency").val()
        }, function(data){
            $("#resource_id").val($("#list_agency").val())
            $("#div_ajax").html(data)
        });
    })

    /* agency list page ends */
    /* Agency Store validation Starts */
    $("#other_store_submit").live("click",function(){
        if ($("#other_agency_id").val() == ""){
            alert("Select Agency Name");
            return false;
        }
        if ($("#category_id").val() == ""){
            alert("Select Category Name");
            return false;
        }
        else if ($("#other_agency_sub_category_id").val() == ""){
            alert("Select Sub Category Name");
            return false;
        }else if ($("#other_agency_resource_id").val() == ""){
            alert("Select Resource Name");
            return false;
        }else if ($("#agency_store_quantity").val() == ""){
            alert("Enter Store Quantity");
            return false;
        }else if ($("#agency_store_uom").val() == ""){
            alert("Enter UOM");
            return false;
        }
    });


    $("#room_store_submit").live("click",function(){
        if ($("#room_agency_id").val() == ""){
            alert("Select Agency Name");
            return false;
        }
        else if ($("#room_agency_sub_category_id").val() == ""){
            alert("Select Sub Category Name");
            return false;
        }
        else if ($("#room_agency_resource_id").val() == ""){
            alert("Select Resource Name");
            return false;
        }
    });


    $("#transport_store_submit").live("click",function(){
        if ($("#transport_agency_id").val() == ""){
            alert("Select Agency Name");
            return false;
        }
        else if ($("#transport_agency_sub_category_id").val() == ""){
            alert("Select Sub Category Name");
            return false;
        }
        else if ($("#transport_agency_resource_id").val() == ""){
            alert("Select Resource Name");
            return false;
        }
        else if ($("#agency_store_driver_id").val() == ""){
            alert("Select Driver Name");
            return false;
        }
    });

    $("#ict_store_submit").live("click",function(){
        if ($("#ict_agency_id").val() == ""){
            alert("Select Agency Name");
            return false;
        }
        else if ($("#ict_agency_sub_category_id").val() == ""){
            alert("Select Sub Category Name");
            return false;
        }
        else if ($("#ict_agency_resource_id").val() == ""){
            alert("Select Resource Name");
            return false;
        }
        else if ($("#agency_store_serial_no").val() == ""){
            alert("Enter Serial Number");
            return false;
        }
    });
    /* Agency Store validation ends */

    /* Approver Starts*/
    $("#approver1_id").live("change", function(){
        if($("#approver1_id").val()!="")
        {
            $.get("/resources/get_approvers",{
                approver_id : $("#approver1_id").val()
            }, function(data){
                if (data[0]!=null)
                {
                    $('#approver2_id').find('option').remove().end()
                    $('#approver2_id').append($("<option></option>").attr("value","").text("SELECT A USER"));
                    for(var i=0; i<data[0].length;i++)
                    {
                        $('#approver2_id').append($("<option></option>").attr("value",data[0][i].user.ic_number).text(data[0][i].user.first_name));
                    }
                }
            })
        }
        else{
            $('#approver2_id').find('option').remove().end()
            $('#approver2_id').append($("<option></option>").attr("value","").text("SELECT A USER"));
        }
    })

    /* Approver Validation*/

    $("#approver_submit").live("click",function(){
        if ($("#approver1_id").val() == ""){
            alert("Select First Approver");
            return false;
        }
        else if ($("#approver2_id").val() == ""){
            alert("Select Second Approver");
            return false;
        }
    })

    /* Resources validation Starts*/
    $("#resource_room_submit").live("click",function(){
        if ($("#resource_sub_category_id").val() == ""){
            alert("Select Sub Category");
            return false;
        }
        else if ($("#resource_resource_no").val() == ""){
            alert("Enter Ext No");
            return false;
        }
        else if ($("#resource_location").val() == ""){
            alert("Enter Location");
            return false;
        }
        else if ($("#resource_capacity").val() == ""){
            alert("Enter Capacity");
            return false;
        }
        else if ($("#resource_capacity").val() <= "0"){
            alert("Capacity should be greater then zero");
            return false;
        }

    })

    $("#resource_transport_submit").live("click",function(){
        if ($("#resource_transport_sub_category_id").val() == ""){
            alert("Select Sub Category");
            return false;
        }
        else if ($("#resource_reg_no_transport").val() == ""){
            alert("Enter Registration No");
            return false;
        }
        else if ($("#resource_vehicle_model").val() == ""){
            alert("Enter Vehicle Model");
            return false;
        }
        else if ($("#resource_capacity_transport").val() == ""){
            alert("Enter No of Passengers");
            return false;
        }
    })
    $("#resource_ict").live("click",function(){
        if ($("#resource_ict_sub_category_id").val() == ""){
            alert("Select Sub Category");
            return false;
        } else if ($("#resource_name").val() == ""){
            alert("Enter Name");
            return false;
        }
        else if ($("#resource_description").val() == ""){
            alert("Enter Description");
            return false;
        }
        else if ($("#resource_brand_model").val() == ""){
            alert("Enter Brand Model");
            return false;
        }
    })
    $("#resource_other_submit").live("click",function(){
        if ($("#resource_other_category_id").val() == ""){
            alert("Select Category");
            return false;
        }
        else if ($("#resource_other_sub_category_id").val() == ""){
            alert("Select Sub Category");
            return false;
        }
        else if ($("#resource_name_others").val() == ""){
            alert("Enter Name");
            return false;
        }
        else if ($("#resource_description_others").val() == ""){
            alert("Enter Description");
            return false;
        }
    })
    /* Resources validation Ends*/



    /* Resource Requisition for ICT starts*/
    $("#check_box_network").live("click",function(){
        $("#req_type_network").show();
        $("#req_type_purchase").hide();
        $("#get_hide").show();
    });

    $("#check_box_purchase").live("click",function(){
        $("#req_type_purchase").show();
        $("#req_type_network").hide();
        $("#get_hide").show();
    });

    $("#check_box_no_recd").live("click",function(){
        $("#get_hide").hide();
    });
    /* Resource Requisition for ICT ends*/

    /* Resource Requisition validation for ICT starts*/
    $("#ict_network_point_submit").live("click",function(){
        if ($("#ict_network_point_status").val() == ""){
            alert("Select Action");
            return false;
        }
        else if ($("#ict_network_point_person_incharge").val() == ""){
            alert("Select Person Incharge");
            return false;
        }
        else if ($("#ict_network_point_remarks").val() == ""){
            alert("Enter Remarks");
            return false;
        }
        else if ($("#check_box_network").val() == ""){
            alert("Select Recommondation Type");
            return false;
        }
        else if ($("#ict_network_point_hardware_id").val() == ""){
            alert("Select Hardware Type");
            return false;
        }
        else if ($("#ict_network_point_type_id").val() == ""){
            alert("Select Hardware Port");
            return false;
        }
        else if ($("#ict_network_point_hardware_quantity").val() == ""){
            alert("Enter Hardware Quantity");
            return false;
        }
        else if ($("#ict_network_point_notes").val() == ""){
            alert("Enter Notes");
            return false;
        }
        else if ($("#ict_network_point_center_id").val() == ""){
            alert("Select Location Center");
            return false;
        }
        else if ($("#ict_network_point_work_status").val() == ""){
            alert("Select Work Status");
            return false;
        }
    });
/* Resource Requisition validation for ICT ends*/



})
/* resource room booking validation ends */
/*Javascripts Starts*/

/*Number Validation*/
function isNumberKey(evt)   {
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if ((charCode >= 48 &&  charCode <= 57) ||  charCode == 8  || charCode==9 || charCode==46)
        return true;
    return false;
}

/*Auto tab functionality in create user*/
function autoTab(e, element, nextElement)
{
    var code;
    if (!e) var e = window.event;
    if (e.which) code = e.which;
    else if (e.keyCode) code = e.keyCode;
    if ((code > 47 && code < 91) || (code > 95 && code < 105))
    {
        if (element.value.length == element.maxLength && nextElement != null)
        {
            nextElement.focus();
        }
    }
}

/*Javascripts Ends*/
/* Validating Transport Request Approval Form */

function validate_request_approval_form(){
    if($("#approve_status").val() == "Declined"){
        var r = confirm("You want to Decline this Request. Continue ?");
        if (r == false)
        {
            return false;
        }
    }
    else if ($("#approve_status").val() == "New"){
        var r = confirm("You didn't Approve this request. Continue ?");
        if (r== false)
        {
            return false;
        }
    }
    else if ($("#approve_status").val() == "Approved"){
        if ($("#vehicle_id").val() == ""){
            alert("Please Select the Vehicle");
            return false;
        }
    }
    else if ($("#approve_status").val() == "Returned"){
        var r = confirm("You want to Return this Request. Continue ?")
        if (r == false)
        {
            return false;
        }
    }
}

/*Javascripts Ends*/

function transport_resource_from_user(id){
    r = confirm("You are going to return the resource. Confirm ?")
    if (r == true){
        $.get("/resource_transportation_bookings/user_return_status",{
            id : id
        });
        document.getElementById('user_return_request_'+id).style.display='none'
        document.getElementById('transport_booking_'+id).style.display='block'
    //,function(data){
    //            $("#user_box_"+id).html(data);
    //        });
    }
    else
    {
        $('#user_returned_status'+id).attr('checked', false);
        return false;
    }
}
function returnIctEquipment(chbx_id,ict_book_id)
{
    if(ict_book_id!=null && ict_book_id!=0)
    {
        s = confirm("Do you Want to Return this Resource?");
        if (s==true)
        {
            if($("#"+chbx_id).is(':checked'))
            {
                $("#div_ict_chk_"+ict_book_id).hide();
                $("#div_ict_msg_"+ict_book_id).show();
                $.post("/resource_ict_equipment_bookings/user_return/",
                {
                    ict_equipment_id:ict_book_id,
                    user_returned_status:true
                }, function(data)
                {
                    if (data[0]=="Success")
                    {
                        alert("Resource returned Successfully.")
                    }
                    else
                    {
                        alert("Resource could not be returned!")
                    }
                });
            }
        }
        else
        {
            $('#user_returned_status_'+ict_book_id).attr('checked', false);
            return false;
        }
    }
}
/* room booking */
function toreturnroomresource(chbx_id,room_book_id)
{
    if(room_book_id!=null && room_book_id!=0)
    {
        s = confirm("Do you Want to Return this Resource?");
        if (s==true)
        {
            if($("#"+chbx_id).is(':checked'))
            {
                document.getElementById('hide_check_box_'+room_book_id).style.visibility = 'hidden'
                document.getElementById('room_box_'+room_book_id).style.display='block'
                $.post("/resource_room_bookings/user_return/",
                {
                    //                    $("#vehicle_type_id").hide()
                    room_book_id:room_book_id,
                    user_returned_status:true
                });
            }
        }
        else
        {
            $('#user_returned_status_'+room_book_id).attr('checked', false);
            return false;
        }
    }
}
/* room booking ends */

/* others booking */
function toreturnresource(chbx_id,room_book_id)
{
    if(room_book_id!=null && room_book_id!=0)
    {
        s = confirm("Do you Want to Return this Resource?");
        if (s==true)
        {
            if($("#"+chbx_id).is(':checked'))
            {
                document.getElementById('hide_check_box_'+room_book_id).style.visibility = 'hidden'
                document.getElementById('room_box_'+room_book_id).style.display='block'
                $.post("/resource_bookings/user_return/",
                {
                    //                    $("#vehicle_type_id").hide()
                    room_book_id:room_book_id,
                    user_returned_status:true
                });
            }
        }
        else
        {
            $('#user_returned_status_'+room_book_id).attr('checked', false);
            return false;
        }
    }
}
/* others booking ends */

/* Resource Other Booking Validation Starts*/

$("#resource_booking_submit").live("click",function(){
    if ($("#other_booking_category_id").val() == ""){
        alert("Select Category");
        return false;
    }
    else if ($("#other_booking_sub_category_id").val() == ""){
        alert("Select Sub Category");
        return false;
    }
    else if ($("#resource_booking_resource_id").val() == ""){
        alert("Select Resource");
        return false;
    }
    else if ($("#resource_booking_requested_from_date").val() == ""){
        alert("Enter From Date");
        return false;
    }
    else if ($("#resource_booking_requested_to_date").val() == ""){
        alert("Enter To Date");
        return false;
    }
    else if ($("#resource_booking_quantity").val() == ""){
        alert("Enter Quantity");
        return false;
    }
    else if ($("#resource_booking_purpose").val() == ""){
        alert("Enter Purpose");
        return false;
    }
    else if ($("#resource_booking_description").val() == ""){
        alert("Enter Description");
        return false;
    }
});
/* Resource Other Booking Validation Ends*/

/* Requisition for Software Validation Starts*/
$("#software_installation_submit").live("click",function(){
    if ($("#software_installation_facility_ict_software_id").val() == ""){
        alert("Select Software Type");
        return false;
    }
    else if ($("#service_name").val() == ""){
        alert("Enter Name");
        return false;
    }
    else if ($("#service_position").val() == ""){
        alert("Enter Position");
        return false;
    }
    else if ($("#service_grade").val() == ""){
        alert("Enter Grade");
        return false;
    }
});
/* Requisition for Software Validation Ends*/

/* Requisition for Network Validation Starts*/
$("#ict_network_point_submit").live("click",function(){
    if ($("#ict_network_point_justification").val() == ""){
        alert("Enter Justification");
        return false;
    }
    else if ($("#ict_network_point_location").val() == ""){
        alert("Enter Location");
        return false;
    }
    else if ($("#ict_network_point_quantity").val() == ""){
        alert("Enter Quantity");
        return false;
    }
});
/* Requisition for Network Validation Ends*/


$("#agency_submit").live("click",function(data){
    if ($("#agency_name").val()=="")
    {
        alert("Enter Agency name");
        return false;
    }
    else if ($("#agency_address").val()=="")
    {
        alert("Enter the Address");
        return false;
    }
    else if($("#agency_telephone_number").val()=="")
    {
        alert("Enter the Telephone Number");
        return false;
    }
    else if($("#agency_fax_number").val()=="")
    {
        alert("Enter the Fax Number");
        return false;
    }
    var regEx = new RegExp("/[0-9]/");
    if ($("#agency_telephone_number").val().length !=10 && !$("#agency_telephone_number").val().match(regEx)) {
        alert("Invalid TelePhone Number");
        return false;
    }
    if ($("#agency_fax_number").val().length !=10 && !$("#agency_fax_number").val().match(regEx)) {
        alert("Invalid Fax Number");
        return false;
    }
    if ($("#agency_name").val()!="" && $("#agency_address").val()!="" && $("#agency_telephone_number").val()!="" && $("#agency_fax_number").val()!="")
    {
        $.get("/agencies/for_agency",{
            name: $("#agency_name").val(),
            address: $("#agency_address").val(),
            telephone_number: $("#agency_telephone_number").val(),
            fax_number: $("#agency_fax_number").val(),
            is_active: $("#agency_is_active").val()
        }, function(data){
            if(data && data[0]=="Success")
            {
                alert("success");
            //                $("#agency_name").val("");
            //                $("#agency_address").val("");
            //                $("#agency_telephone_number").val("");
            //                $("#agency_fax_number").val("");
            //                $("#agency_is_active").val("");
            }
            else if(data && data[0]=="Failure")
            {
                alert("Failure")
            }
        });
    }
});
$("#resource_type").live("change",function(){
    $.get("/agency_stores/",{
        resource_type: $("#resource_type").val()
    }, function(data){
        $("#resource_type").val($("#resource_type").val())
        $("#div_ajax").html(data)
    });
})
$("#edit_for_agency").live("click",function(){
    $.ajax("agencies/edit", function(data) {
        alert("comes here");
        alert(data);
    });
});
/* Complaints - Building Assets */
$("#complaint_building_asset_building_asset_type_id").live("change", function(){
    if($("#complaint_building_asset_building_asset_type_id").val()!="")
    {
        $.get("/complaint_building_assets/get_categories",{
            category_id : $("#complaint_building_asset_building_asset_type_id").val()
        }, function(data){
            if (data[0]!=null)
            {

                $('#complaint_building_asset_type_id').find('option').remove().end()
                $('#complaint_building_asset_type_id').append($("<option></option>").attr("value","").text("SELECT A TYPE"));
                for(var i=0; i<data[0].length;i++)
                {
                    $('#complaint_building_asset_type_id').append($("<option></option>").attr("value",data[0][i].building_asset_type.id).text(data[0][i].building_asset_type.name));
                }
            }
        })
    }

});

$("#complaint_building_asset_type_id").live("change", function(){
    if($("#complaint_building_asset_type_id").val()!="")
    {
        $.get("/complaint_building_assets/get_categories_types",{
            category_type_id : $("#complaint_building_asset_type_id").val()
        }, function(data){
            if (data[0]!=null)
            {

                $('#complaint_building_asset_item_id').find('option').remove().end()
                $('#complaint_building_asset_item_id').append($("<option></option>").attr("value","").text("SELECT A ITEM"));
                for(var i=0; i<data[0].length;i++)
                {
                    $('#complaint_building_asset_item_id').append($("<option></option>").attr("value",data[0][i].building_asset_type.id).text(data[0][i].building_asset_type.name));
                }
            }
        })
    }

});
/* End Complaint - Building Assets */

/* Complaints - Computers */
$("#complaint_computer_complaint_type_id").live("change", function(){
    if($("#complaint_computer_complaint_type_id").val()!="")
    {
        $.get("/complaint_computers/get_system_types",{
            system_access_id : $("#complaint_computer_complaint_type_id").val()
        }, function(data){
            if (data[0]!=null)
            {
                $('#complaint_computer_system_access_id').find('option').remove().end()
                $('#complaint_computer_system_access_id').append($("<option></option>").attr("value","").text("SELECT AN ITEM / SYSTEM TYPE"));
                for(var i=0; i<data[0].length;i++)
                {
                    $('#complaint_computer_system_access_id').append($("<option></option>").attr("value",data[0][i].system_access.id).text(data[0][i].system_access.name));
                }
            }
        })
    }

});

$("#complaint_computer_system_access_id").live("change", function(){
    if($("#complaint_computer_system_access_id").val()!="")
    {
        $.get("/complaint_computers/get_system_items",{
            system_model_type_id : $("#complaint_computer_system_access_id").val()
        }, function(data){
            if (data[0]!=null)
            {

                $('#complaint_computer_system_model_type_id').find('option').remove().end()
                $('#complaint_computer_system_model_type_id').append($("<option></option>").attr("value","").text("SELECT A MODEL ITEM / SYSTEM"));
                for(var i=0; i<data[0].length;i++)
                {
                    $('#complaint_computer_system_model_type_id').append($("<option></option>").attr("value",data[0][i].system_model_type.id).text(data[0][i].system_model_type.name));
                }
            }
        })
    }

});


/* End Complaint - Computers */

/*Dynamic Chance for Resource Req ICT Starts */
$("#requisition_type_id").live("change",function(){
    if ($("#requisition_type_id").val() == "1"){
        $("#network_for_ict").show();
        $("#show_text").hide();
        $("#firewall_for_ict").hide();
        $("#hardware_for_ict").hide();
        $("#software_for_ict").hide();
        $("#system_access_for_ict").hide();
        $("#vpn_for_ict").hide();
    }
    else if ($("#requisition_type_id").val() == "2"){
        $("#network_for_ict").hide();
        $("#show_text").hide();
        $("#firewall_for_ict").show();
        $("#hardware_for_ict").hide();
        $("#software_for_ict").hide();
        $("#system_access_for_ict").hide();
        $("#vpn_for_ict").hide();
    }
    else if ($("#requisition_type_id").val() == "3"){
        $("#network_for_ict").hide();
        $("#show_text").hide();
        $("#firewall_for_ict").hide();
        $("#hardware_for_ict").hide();
        $("#software_for_ict").hide();
        $("#system_access_for_ict").hide();
        $("#vpn_for_ict").show();
    }
    else if ($("#requisition_type_id").val() == "4"){
        $("#network_for_ict").hide();
        $("#firewall_for_ict").hide();
        $("#show_text").hide();
        $("#hardware_for_ict").show();
        $("#software_for_ict").hide();
        $("#system_access_for_ict").hide();
        $("#vpn_for_ict").hide();
    }
    else if ($("#requisition_type_id").val() == "5"){
        $("#network_for_ict").hide();
        $("#firewall_for_ict").hide();
        $("#hardware_for_ict").hide();
        $("#software_for_ict").show();
        $("#show_text").hide();
        $("#system_access_for_ict").hide();
        $("#vpn_for_ict").hide();
    }
    else if ($("#requisition_type_id").val() == "6"){
        $("#network_for_ict").hide();
        $("#show_text").hide();
        $("#firewall_for_ict").hide();
        $("#hardware_for_ict").hide();
        $("#software_for_ict").hide();
        $("#system_access_for_ict").show();
        $("#vpn_for_ict").hide();
    }
});
/*Dynamic Chance for Resource Req ICT Ends */

