# == Schema Information
#
# Table name: conversations
#
#  id            :integer          not null, primary key
#  teacher_id    :integer
#  student_id    :integer
#  teacher_email :string
#  student_email :string
#  teacher_name  :string
#  student_name  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ConversationsController < ApplicationController

  def create
    c = Conversation.new(conversation_params)
    
    if c.save
      p "Conversation saved"
      flash[:success] = "Conversation created"
    else
      flash[:danger] = "Conversation not created #{ c.errors.full_messages}"
    end
    # p "Hit conversation controller/send_message"
    # ConversationMailer.send_message(params['email']).deliver_now
    # flash[:success] = "Yippee"
    redirect_to :back
  end

  private
    def conversation_params
      params.require(:conversation).permit(:teacher_id, :student_id, :teacher_email, :student_email, :teacher_name,
                                            :student_name, :message)
    end
end
