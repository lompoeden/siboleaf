class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  #validates :enddate, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  paginates_per 4
  has_many :associations, dependent: :destroy, foreign_key: 'task_id'
  belongs_to :user
  has_many :labels, through: :associations, source: :label
  accepts_nested_attributes_for :associations
end
