class DonkeykingsController < ApplicationController
  def new
    @donkeykings = Donkeyking.include(:user)
    @donkeyking = Donkeyking.new
  end

  def create
    @donkeyking = Donkeyking.create(donkeyking_params)
  end


  private

  def donkeyking_params
    params.require(:donkeyking).permit(:tweet, :deleted_at).merge(user_id: current_user.id)
  end
  
end