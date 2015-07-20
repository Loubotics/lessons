require 'rails_helper'
require 'database_cleaner'

describe "saving prices common attributes" do
	before (:each) do 
		DatabaseCleaner.strategy = :truncation

		# then, whenever you need to clean the DB
		DatabaseCleaner.clean
		
		# subject = FactoryGirl.create(:subject)
		# teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		# login_as(teacher, scope: :teacher)
	end

	it "should fail all validations" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		click_link_or_button 'home_price_submit_button'

		
		expect(page).to have_content %Q(Couldn't update prices ["Price can't be blank", "Price is not a number", "Duration must be greater than 0"])
	end	
end

describe "home price form validations" do
	before (:each) do 
		DatabaseCleaner.strategy = :truncation

		# then, whenever you need to clean the DB
		DatabaseCleaner.clean
		
	end

	it "should fail if teacher_id is incorrect" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'
		fill_in 'home_price_price', with: '50'
		fill_in 'home_price_duration', with: '30'
		
		select 'Drums', from: 'home_price_subject_id'
		find('#home_price_teacher_id', visible: false).set(2)
		find('#home_price_no_map', visible: false).set(true)
		click_link_or_button 'home_price_submit_button'
		expect(page).to have_content('You are not the correct teacher')
	end

	it "should fail when subject_id is blank" do
		teacher = FactoryGirl.create(:teacher)

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'home_price_price', with: '50'
		fill_in 'home_price_duration', with: '30'
		find('#home_price_no_map', visible: false).set(true)
		click_link_or_button 'home_price_submit_button'
		expect(page).to have_content %Q(Couldn't update prices ["Subject can't be blank"])

	end

	it "should fail when teacher_id is blank" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'home_price_price', with: '50'
		fill_in 'home_price_duration', with: '30'
		select 'Drums', from: 'home_price_subject_id'
		find('#home_price_no_map', visible: false).set(true)
		find('#home_price_teacher_id').set("")
		click_link_or_button 'home_price_submit_button'
		expect(page).to have_content('You are not the correct teacher')
	end

	it "should fail when price is blank" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'home_price_duration', with: '30'
		select 'Drums', from: 'home_price_subject_id'
		find('#home_price_no_map', visible: false).set(true)
		click_link_or_button 'home_price_submit_button'
		expect(page).to have_content %Q(Couldn't update prices ["Price can't be blank", "Price is not a number"])
	end

	it "should fail when no_map is not true/false" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'home_price_price', with: '50'
		fill_in 'home_price_duration', with: '30'
		select 'Drums', from: 'home_price_subject_id'
		find('#home_price_no_map', visible: false).set('hello')
		click_link_or_button 'home_price_submit_button'
		expect(page).to have_content "No map must be a boolean"
	end

	it "should fail when duration is blank" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'home_price_price', with: '50'
		select 'Drums', from: 'home_price_subject_id'
		find('#home_price_no_map', visible: false).set(true)
		click_link_or_button 'home_price_submit_button'
		expect(page).to have_content %Q(Couldn't update prices ["Duration must be greater than 0"])
	end	
end #home price form validations

describe "it should create a home_price" do
	before (:each) do 
		DatabaseCleaner.strategy = :truncation

		# then, whenever you need to clean the DB
		DatabaseCleaner.clean
		
	end

	it "should save a home price" do

		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'home_price_price', with: '50'
		fill_in 'home_price_duration', with: '30'
		select 'Drums', from: 'home_price_subject_id'
		find('#home_price_no_map', visible: false).set(true)
		click_link_or_button 'home_price_submit_button'
		expect(page).to have_content('Prices updated')
	
	end
end

describe "location price validations" do
	before (:each) do 
		DatabaseCleaner.strategy = :truncation

		# then, whenever you need to clean the DB
		DatabaseCleaner.clean
		
	end

	it "should fail if teacher_id is incorrect" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'
		fill_in 'location_price_price', with: '50'
		fill_in 'location_price_duration', with: '30'
		
		select 'Drums', from: 'location_price_subject_id'
		find('#location_price_teacher_id', visible: false).set(2)
		find('#location_price_no_map', visible: false).set(true)
		click_link_or_button 'location_price_button_submit'
		expect(page).to have_content('You are not the correct teacher')
	end

	it "should fail when subject_id is blank" do
		teacher = FactoryGirl.create(:teacher)

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'location_price_price', with: '50'
		fill_in 'location_price_duration', with: '30'
		find('#location_price_no_map', visible: false).set(true)
		click_link_or_button 'location_price_button_submit'
		expect(page).to have_content %Q(Couldn't update prices ["Subject can't be blank"])

	end

	it "should fail when teacher_id is blank" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'location_price_price', with: '50'
		fill_in 'location_price_duration', with: '30'
		select 'Drums', from: 'location_price_subject_id'
		find('#location_price_no_map', visible: false).set(true)
		find('#location_price_teacher_id').set("")
		click_link_or_button 'location_price_button_submit'
		expect(page).to have_content('You are not the correct teacher')
	end

	it "should fail when price is blank" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'location_price_duration', with: '30'
		select 'Drums', from: 'location_price_subject_id'
		find('#location_price_no_map', visible: false).set(true)
		click_link_or_button 'location_price_button_submit'
		expect(page).to have_content %Q(Couldn't update prices ["Price can't be blank", "Price is not a number"])
	end

	it "should fail when no_map is not true/false" do
		subject = FactoryGirl.create(:subject)
		location = FactoryGirl.create(:location)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject], locations: [location])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'location_price_price', with: '50'
		fill_in 'location_price_duration', with: '30'
		select 'Drums', from: 'location_price_subject_id'
		select 'Home', from: 'location_price_location_id'
		page.find('#location_price_no_map', visible: false).set('hello')
		click_link_or_button 'location_price_button_submit'
		expect(page).to have_content "No map must be a boolean"
	end  

	it "should fail when duration is blank" do
		subject = FactoryGirl.create(:subject)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		fill_in 'location_price_price', with: '50'
		select 'Drums', from: 'location_price_subject_id'		
		find('#location_price_no_map', visible: false).set(true)
		click_link_or_button 'location_price_button_submit'
		expect(page).to have_content %Q(Couldn't update prices ["Duration must be greater than 0"])
	end	
end #location price validations

describe "it should create a location price" do
	before (:each) do 
		DatabaseCleaner.strategy = :truncation

		# then, whenever you need to clean the DB
		DatabaseCleaner.clean
		
	end

	it "should pass when setting a location price" do
		subject = FactoryGirl.create(:subject)
		location = FactoryGirl.create(:location)
		teacher = FactoryGirl.create(:teacher, :subjects => [subject], locations: [location])

		login_as(teacher, scope: :teacher)

		visit 'teachers/1/your-business'

		select 'Drums', from: 'location_price_subject_id'
		select 'Home', from: 'location_price_location_id'
		fill_in 'location_price_price', with: '50'
		fill_in 'location_price_duration', with: '30'
		
		find('#location_price_no_map', visible: false).set(false)
		click_link_or_button 'location_price_button_submit'
		expect(page).to have_content('Prices updated')
	end
end