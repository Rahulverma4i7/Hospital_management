class Doctor::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_doctor!

  def index
    @patients = Patient.all
    @patient_data = Patient.group_by_day(:created_at).count
  end
  def patient_trends
  @patient_data = Patient.where("created_at >= ?", 30.days.ago)
                        .group_by_day(:created_at)
                        .count
  # For debugging - check what data is being generated
  puts "Patient trends data: #{@patient_data.inspect}"
  end

  private

  def ensure_doctor!
    unless current_user.doctor?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
