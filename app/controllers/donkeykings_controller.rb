class DonkeykingsController < ApplicationController
  def new
    @donkeykings = Donkeyking.all
    @donkeyking = Donkeyking.new
  end

  def create
    @donkeyking = Donkeyking.create(donkeyking_params)
    redirect_to new_donkeyking_path
  end


  private

  def delete_time
    deleted_at = Time.now + 60 * 60
  end

  def donkeyking_params
    params.require(:donkeyking).permit(:tweet).merge(user_id: current_user.id, deleted_at: delete_time)
  end

end