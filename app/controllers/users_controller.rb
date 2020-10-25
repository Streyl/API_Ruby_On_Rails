class UsersController < ApplicationController
  before_action :set_user, set_auth, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: {
      name: @user.name,
      sirname: @user.sirname,
      hobby: @user.hobby
    }
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if @auth.uuid == params[:uuid] && @auth.secret_token == params[:secret_token]
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @auth.uuid == params[:uuid] && @auth.secret_token == params[:secret_token]
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { render :edit }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end  
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @auth.uuid == params[:uuid] && @auth.secret_token == params[:secret_token]
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to users_url, notice: 'Can't destroy user.' }
        format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_auth
      @auth = Auth.find(params[:id])
    end

    def auth_params
      params.require(:auth).permit(:uuid, :secret_token)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :sirname, :hobby)
    end


end
