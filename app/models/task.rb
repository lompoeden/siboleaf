class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :startdate, presence: true
  validates :priority, presence: true
end
