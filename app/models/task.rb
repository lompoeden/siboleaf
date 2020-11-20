class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :status, presence: true
    validates :priority, presence: true
    #validates :startdate, presence: true
end
