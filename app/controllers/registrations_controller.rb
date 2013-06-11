class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  # layout 'password'
  # GET /resource/sign_up
  def new
    resource = build_resource({})
    respond_with resource
  end

  # POST /resource
  def create
    build_resource
    ic_number = params[:num1] + params[:num2] + params[:num3] # to get ic number as 3 parts
    resource.ic_number = ic_number
    if resource.save
      resource.role_memberships.create(:role_id=> params[:users][:role], :department_id=>params[:users][:department],:status=>STATUS_INACTIVE)
      if resource.active_for_authentication?
        
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    if params[:user][:password]
      if resource.update_with_password(params[:user])
        if is_navigational_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
        sign_in resource_name, resource, :bypass => true
        session[:password_changed]="true"
        redirect_to :controller => "users"
      else
        clean_up_passwords resource
        render :action=>"users/account_setting"
      end
    else
      if resource.update_without_password(params[:user])
        clean_up_passwords resource
        redirect_to :controller => "users"
      else
        render :action=>"edit"
      end
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_session_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected
  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  def after_sign_up_path_for(resource)
    flash[:notice]="Your request has been sent to Admin. Once approved you get mail!"
    root_path
  end

  def privacy_setting
    #    redirect_to :controller => "registrations", :action => "update"
  end
end
