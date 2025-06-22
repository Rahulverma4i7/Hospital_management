class Doctor::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_doctor!

  def index
    @patients = Patient.all
    @patient_data = Patient.group_by_day(:created_at).count
  end

  private

  def ensure_doctor!
    unless current_user.doctor?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end