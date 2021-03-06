# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  name           :string
#  imageable_id   :integer
#  imageable_type :string
#  created_at     :datetime
#  updated_at     :datetime
#  avatar         :string
#

class PhotosController < ApplicationController
	include PhotosHelper

	before_action :authenticate_teacher!
	
	def new 
		@context = context
		@photo = Photo.new	
	end

	def create
		@context = context
		# if params[:profile] == 'true'
		# 	photo_params[:filename] = 'profile'
		# end
		@photo = @context.photos.build(photo_params)
		respond_to do |format|
			if @photo.save
				
				format.html { flash[:success] = "Photo uploaded successfully!"
					redirect_to edit_teacher_path(current_teacher) }
				format.json { flash[:success] = "Photo uploaded successfully!"
					render json: @photo }
			else
				flash[:danger] = "Couldn't upload photo #{@photo.erros.full_messages}"
				render edit_teacher_path(current_teacher)
			end
		end
	end

	def destroy
		@context = context
		@photo = @context.photos.find(params[:id])
		checkProfile(params[:id])
		if @photo.destroy
			flash[:success] = "Photo deleted!"
			redirect_to :back
		else
			flash[:error] = "Could not delete photo #{@photo.errors.full_messages}"
			redirect_to :back
		end
	end

	private
		def context 
			if params[:teacher_id]
				Teacher.find(params[:teacher_id])
			end
		end

		def photo_params
			params.require(:photo).permit!
		end
end
