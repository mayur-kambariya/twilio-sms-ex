class UsersController < ApplicationController
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(add_params)
    if @user.save
      render text: "Thank you! You will receive an SMS shortly."
      
      # Instantiate a Twilio client
      client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
      
      # Create and send an SMS message
      client.account.sms.messages.create(
        from: TWILIO_CONFIG['from'],
        to: @user.phone,
        body: params[:user][:body]
      )
    else
      render :new
    end
  end

  private
  def add_params    
    params.require(:user).permit(:email,:phone, :name,:body) if params[:user].present?
  end
end
