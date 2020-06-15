class NotificationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def index
      @notifications = PublicActivity::Activity.where(recipient_id: current_user.id)    
    end
  
    def read_all   
      PublicActivity::Activity.where(recipient_id: current_user.id).update_all({readed: true})
      render :nothing => true
    end
  
  end