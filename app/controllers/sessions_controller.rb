class SessionsController < ApplicationController
  def new
  end

  def create
    # 送信されたユーザーのメールアドレスを使って、データベースから取り出す
    user = User.find_by(email: params[:session][:email].downcase)
    # もしuserが有効かつ送信されたユーザーのパスワードが一致していたら
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'メールアドレスかパスワードが無効です'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
