# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  overview               :text             default("")
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  admin                  :boolean
#  profile                :integer
#  is_teacher             :boolean          default(FALSE), not null
#  paypal_email           :string           default("")
#  stripe_access_token    :string           default("")
#  is_active              :boolean          default(FALSE), not null
#  will_travel            :boolean          default(FALSE), not null
#  stripe_user_id         :string
#  address                :string           default("")
#  paid_up                :boolean          default(FALSE)
#  paid_up_date           :date
#  profile_views          :integer          default(0)
#

require 'rails_helper'
require 'spec_helper'
include Devise::TestHelpers

describe TeachersController do
	
	
	before(:each) do
		@request.env["devise.mapping"] = Devise.mappings[:teacher]
		DatabaseCleaner.strategy = :truncation
		DatabaseCleaner.clean
		@teacher = FactoryGirl.create(:teacher)
		sign_in :teacher, @teacher
		@request.env['HTTP_REFERER'] = 'http://localhost:3000/teachers/1/your-location'
	end
	
	it "should get edit" do
		get :edit, id: @teacher
		expect(response).to be_success
	end
	

	it "should get qualification-form" do
		get :qualification_form, id: @teacher
		expect(response).to be_success
	end

	it "shold get your_business" do
		get :your_business, id: @teacher
		expect(response).to be_success
	end

	it "should get teachers_area" do
		get :teachers_area, id: @teacher
		expect(response).to be_success
	end

	it "should get previous_lessons" do
		get :previous_lessons, id: @teacher
		expect(response).to be_success
	end

	describe "update paypal_email" do
		it "should fail when email is incorrect" do
			put :update, id: @teacher, teacher: { paypal_email: "lllouiss@yahoo.com", paypal_first_name: 'Louiss', paypal_last_name: 'Angelinis' }
			expect(flash[:danger]).to be_present
		end
		it "should fail when last name is incorrect" do
			put :update, id: @teacher, teacher: { paypal_email: "lllouis@yahoo.com", paypal_first_name: 'Louis', paypal_last_name: 'Angelinis' }
			expect(flash[:danger]).to be_present
		end	

		it "should fail when first name is incorrect" do
			put :update, id: @teacher, teacher: { paypal_email: "lllouis@yahoo.com", paypal_first_name: 'Louiss', paypal_last_name: 'Angelini' }
			expect(flash[:danger]).to be_present
		end

		it "should update paypal email when params are corrects" do
			put :update, id: @teacher, teacher: { paypal_email: "lllouis@yahoo.com", paypal_first_name: 'Louis', paypal_last_name: 'Angelini' }
			expect(flash[:success]).to be_present
		end
	end #update paypal email

	describe "update profile picture" do
		it "should update profile picture id" do
			post :change_profile_pic, id: @teacher.id, picture_id: 2
			@teacher.reload
			expect(@teacher.profile).to eq(2)
			expect(flash[:success]).to be_present
		end
	end

	# describe "previous_lessons" do
	# 	it "should display previous events" do
	# 		event = FactoryGirl.create(:event)
	# 		get :previous_lessons
	# 		expect(Event, :count).to eq(1)
	# 	end
	# end

	describe "delete teacher" do
		
		it "should't work when current_teacher isn't admin" do
			teacher = FactoryGirl.create(:teacher)
			delete :destroy, id: teacher.id
			expect(flash[:danger]).to be_present
		end

		it "should work when teacher is an admin" do
			sign_out @teacher
			@admin = FactoryGirl.create(:teacher, :admin)
			sign_in :teacher, @admin
			teacher = FactoryGirl.create(:teacher)
			expect{
				delete :destroy, id: teacher.id
			}.to change(Teacher, :count).by(-1)
			
			expect(flash[:success]).to be_present
		end
	end

	
end #TeachersController
