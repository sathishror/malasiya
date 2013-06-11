class SettingsController < ApplicationController
  def update_timeline_for_approver
    @val = Setting.find(:all)
    if !@val.present?
      @setting = Setting.create(params[:setting])
      redirect_to(account_setting_users_path, :notice => "Time Line has been Set for Approval")
    else
      @setting = Setting.find_by_id(1)
      @setting.update_attributes(params[:setting])
      redirect_to(account_setting_users_path, :notice => "Time Line has been Set for Approval")
    end
  end
end
