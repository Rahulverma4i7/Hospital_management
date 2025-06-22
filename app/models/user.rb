class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { receptionist: 'receptionist', doctor: 'doctor' }, default: 'receptionist'

  def doctor?
    role == 'doctor'
  end

  def receptionist?
    role == 'receptionist'
  end
end