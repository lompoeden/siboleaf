class Label < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :user_id
  has_many :task_labels, dependent: :destroy
  has_many :tasks, through: :task_labels
  end
