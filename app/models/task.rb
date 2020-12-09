class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  #validates :enddate, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  paginates_per 4
  belongs_to :user
end
