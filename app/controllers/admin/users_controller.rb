class Admin::UsersController < AdminController
   def index
     @users = User.all
   end

   def edit
     @user = User.find_by_friendly_id!(params[:id])
   end

   def update
     @user = User.find_by_friendly_id!(params[:id])
     if @user.update(user_params)
       redirect_to admin_users_path
     else
       render "edit"
     end
   end

  def bulk_mail
    total = 0
    Array(params[:ids]).each do |user_id|
      user = User.find(user_id)
      UserMailer.notify_welcome_info(user).deliver_later
      total += 1
    end

    flash[:alert] = "成功完成 #{total} 笔"
    redirect_to admin_users_path
  end
   protected

   def user_params
     params.require(:user).permit(:email, :role)
   end
end
