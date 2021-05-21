class UsersController < ApplicationController
  include SessionsHelper

  # GET /users or /users.json
  def index
    #binding.pry
    @users = User.all
    @user = User.find(current_user.id)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id != current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    #@currentUserEntry = Entry.where(user_id: current_user.id)
    #@userEntry = Entry.where(user_id: @user.id)
    #unless @user.id == current_user.id
    #  @currentUserEntry.each do |cu|
    #    @userEntry.each do |u|
    #      if cu.room_id == u.room_id then
    #        @isRoom = true
    #        @roomId = cu.room_id
    #      end
    #    end
    #  end
    #  unless @isRoom
    #    @room = Room.new
    #    @entry = Entry.new
    #  end
    #end
  end
  
  def favorites
    @user = User.find(params[:id])
  end
  
  def follows
    @user = User.find(params[:id])
  end
  
  def followers
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password_digest, :salt)
    end
end
