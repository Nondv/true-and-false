class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :attempts

  START_UP_RAITING = 1000

  def raiting
    START_UP_RAITING + attempts.map(&:points).reduce(0, &:+)
  end
end
