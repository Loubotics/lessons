# == Schema Information
#
# Table name: user_carts
#
#  id            :integer          not null, primary key
#  teacher_id    :integer
#  student_id    :integer
#  params        :text
#  tracking_id   :text
#  student_name  :string(255)      default("")
#  student_email :string(255)
#  teacher_email :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  subject_id    :integer
#

class UserCart < ActiveRecord::Base
  belongs_to :teacher
  serialize :params

  validates :teacher_id, :student_id, :params, :tracking_id, presence: true
  validates :tracking_id, uniqueness: true

  # before_update :save_tracking_id
  # before_save :save_tracking_id
  before_validation :save_tracking_id

  def save_tracking_id
    puts "blvvalvavl"
    self.tracking_id = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
