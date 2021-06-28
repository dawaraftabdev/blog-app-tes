class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
    begin
      @user = User.is_valid_user(params[:email], params[:password])
      api_token = SecureRandom.hex(16)
      @user.sessions.build(api_token: api_token)
      if @user.save
        json = @user.as_json.except("sessions")
        json["api_token"] = api_token
        json['id'] = @user.id.to_s

        sign_in @user
        render json: {
          user: json,
          success: true
        }
      else
        render json: {
          success: false,
          error: @user.errors.full_messages.to_sentence
        }
      end
      
    rescue Exception => e
      render json: {
        success: false,
        error: 'Email/Password Does not match'
      }
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.present?
      session = @user.sessions.find_by(api_token: params[:api_token])
      if session.present?
        session.destroy
        render json: {
          success: true,
          error: "User logged out sucessfully"
        }
      else
        render json: {
          success: false,
          error: "Please login to proceed"
        }
      end
    else
      render json: {
        success: false,
        error: "User not found."
      }
    end
  end

end
