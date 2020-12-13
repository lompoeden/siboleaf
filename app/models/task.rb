class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user, optional: true
  #validates :enddate, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  paginates_per 6
  has_many :tasks_labels, dependent: :destroy
  has_many :labels, through: :tasks_labels
end
