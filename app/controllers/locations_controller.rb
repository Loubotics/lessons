# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  latitude   :float
#  longitude  :float
#  name       :string
#  address    :text
#  created_at :datetime
#  updated_at :datetime
#

class LocationsController < ApplicationController

  before_action :authenticate_teacher!

  def create
    
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = 'Location added'
      redirect_to :back
    else
      flash[:danger] = "Couldn't save location #{ @location.errors.full_messages }"
      redirect_to :back
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      flash[:success] = "Location data updated"
    else
      flash[:danger] = "Couldn't update location data #{ @location.errors.full_messages }"
    end
    redirect_to :back
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      flash[:success] = "Location deleted!"
    else
      flash[:danger] = "Couldn't delete location: #{ @location.errors.full_messages }"
    end
    redirect_to :back
  end


  private
    def location_params
      params.require(:location).permit(:teacher_id, :latitude, :longitude, :name, :address)
    end
end
