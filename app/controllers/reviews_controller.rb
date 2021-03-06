# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  user_id    :integer
#  teacher_id :integer
#  created_at :datetime
#  updated_at :datetime
#  comment    :text
#  event_id   :integer
#

class ReviewsController < ApplicationController
  before_action :authenticate_teacher!
  def create
    
    @review = Review.new(review_params)
    if @review.save
      @review.add_review_to_event(params[:review][:event_id])
      flash[:success] = "Review created"
    else
      flash[:danger] = "Review could not be created #{@review.errors.full_messages}"
    end
    redirect_to :back
  end

  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "Review deleted"
    redirect_to :back
  end

  private 

    def review_params
      params.require(:review).permit!
    end

end
