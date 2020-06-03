class UsersController < ApplicationController
    def show  
        @user = if params[:id]
            User.find_by(id: params[:id])
         else
          current_user
         end
         @phrases = @user.phrases
    end

    def index 
        @users = User.paginate(page: params[:page], per_page: 10  )
    end
end
