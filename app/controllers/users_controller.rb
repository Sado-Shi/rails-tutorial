class UsersController < ApplicationController
  # ログインしてなければ、リダイレクトするリスト
    before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy]
  # ログインしているユーザーが自分か判定するリスト
    before_action :correct_user,   only: [:edit, :update]
  # 管理者だけが、destroyアクションに触れるように
    before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ようこそ！"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新が完了しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "ユーザーを削除しました"
      redirect_to users_url
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

        # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインして下さい"
        redirect_to login_url
      end
    end

        # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(current_user) unless current_user?(@user)
    end

        # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
