class TeachersController < ApplicationController
	layout 'teacher_layout'
	before_action :authenticate_teacher!
	before_action :check_id, only: [:update]
	include TeachersHelper


	def check_id
		redirect_to root_path unless current_teacher.id = params[:id]
	end

	def edit
		@context = Teacher.find(current_teacher)
		@photo = @context.photos.new
		@context.profile == nil ? @profilePic = nil : @profilePic = Photo.find(@context.profile)
		@experience = Experience.new
		@params = params
		@photos = @context.photos.all
		@experience = Experience.new
		@experiences = @context.experiences		
	end
	
	def update		
		@teacher = Teacher.find(current_teacher)
		if params[:teacher]['opening(5i)']
			(teacher_params = addTime(params)) 
		end
		if @teacher.update_attributes(teacher_params)
			flash[:success] = 'Details updated ok'
			redirect_to :back
		end
	end

	def teachers_area
		@params = params
		@teacher = Teacher.find(current_teacher)
		gon.events = format_times(@teacher.events)
		gon.openingTimes = open_close_times(current_teacher.opening, current_teacher.closing)
		@event = @teacher.events.new
		@opening = checkOpeningExists()

	end

	def qualification_form
		@context = Teacher.find(current_teacher)
		@qualifications = Qualification.where(teacher_id: current_teacher.id)
		@qualification = @context.qualifications.new
	end

	def your_location
		@teacher = Teacher.find(current_teacher)
		gon.location = [@teacher.lat,@teacher.lon]
	end

	def change_profile_pic
		@params = params
		@teacher = Teacher.find(current_teacher)
		@teacher.update_attributes(profile: params[:id])
		flash[:notice] = 'Profile picture updated'
		redirect_to :back
	end

	private
		def teacher_params
			params.require(:teacher).permit!
		end

		def addTime(params)
			opening = Time.zone.parse(params[:teacher]['opening(5i)'])
			closing = Time.zone.parse(params[:teacher]['closing(5i)'])
			returned_params = { opening: opening, closing: closing }
		end

		def checkOpeningExists	
			@opening = Opening.find_or_create_by(teacher_id: current_teacher.id)		
			# if opening = Opening.where(teacher_id: current_teacher.id)
			# 	puts "//////////////////a"
			# 	Opening.where(teacher_id: current_teacher.id)
			# else
			# 	puts "///////////////////b"
			# 	Teacher.find(current_teacher).openings.new
			# end
		end
end
