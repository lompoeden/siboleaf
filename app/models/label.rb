class Label < ApplicationRecord
  belongs_to :user
    validates_presence_of :name, :content, :user_id
    has_many :tasks_labels, dependent: :destroy
    has_many :tasks, through: :tasks_labels
  end
