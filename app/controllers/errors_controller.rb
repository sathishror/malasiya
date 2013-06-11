class ErrorsController < ApplicationController
  def not_found 
  end
  
  def blocked
    render :file => Rails.root.join('public/blocked.html')
  end
end
