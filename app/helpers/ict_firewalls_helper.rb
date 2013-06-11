module IctFirewallsHelper

  
  def add_selection_box(name,  form)

   page = %{
      partial = "#{escape_javascript(render(:partial => "ict_firewalls/ict_firewall_services",:locals => { :f => form }))}";

      $("#std").append(partial);
    }

    link_to_function name, page
  end


end
