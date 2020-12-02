class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  #validates :enddate, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  paginates_per 4
end
