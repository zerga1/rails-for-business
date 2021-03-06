# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  nickname   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Student < ActiveRecord::Base
  has_and_belongs_to_many :works
  has_many :tasks, through: :works

  def available_tasks
    Task.all - self.tasks - Task.where(one_time: true).select{|task| task.students.any? }
  end
end
