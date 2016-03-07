class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :schedules
  has_many :notes
  has_many :theses
  belongs_to :department
  belongs_to :laboratory
  has_many :resources
end
