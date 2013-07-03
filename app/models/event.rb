class Event < ActiveRecord::Base
  belongs_to :user

  validates :name, 
            :details, 
            :date, presence: true
end

