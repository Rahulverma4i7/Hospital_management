class Receptionist::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_receptionist!

  def index
    @patients = Patient.all
  end

  private

  def ensure_receptionist!
    unless current_user.receptionist?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end