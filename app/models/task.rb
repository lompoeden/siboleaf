class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :status, presence: true
    validates :priority, presence: true
    has_many :task_labels, dependent: :destroy
    has_many :labels, through: :task_labels
    end
