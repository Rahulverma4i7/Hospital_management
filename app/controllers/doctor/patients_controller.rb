module Doctor
  class PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_doctor!
    before_action :set_patient, only: [ :show ]

  def index
  @patients = Patient.all.order(created_at: :desc)
  # Get last 30 days, including days with zero patients
  date_range = (Date.today - 29.days)..Date.today
  @registration_data = Patient
    .group_by_day(:created_at, range: date_range, format: "%b %d")
    .count
    .transform_values(&:to_i) # Ensure all values are integers
  end


    def create_sample_data
      # Clear existing test patients (optional)
      Patient.where("first_name LIKE ?", "Test%").destroy_all

      # Create 30 varied sample patients
      30.times do |i|
        Patient.create!(
          first_name: "Test",
          last_name: "Patient #{i+1}",
          dob: Faker::Date.birthday(min_age: 18, max_age: 90),
          gender: [ "Male", "Female", "Other" ].sample,
          phone: Faker::PhoneNumber.cell_phone,
          address: Faker::Address.full_address,
          created_at: Faker::Time.between(from: 30.days.ago, to: Time.now)
        )
    end

      redirect_to doctor_patients_path,
        notice: "Successfully generated 30 sample patient records"
    rescue => e
      redirect_to doctor_patients_path,
        alert: "Error generating samples: #{e.message}"
    end

    def show
      @patient = Patient.find(params[:id])
    end

    private

    def set_patient
      @patient = Patient.find_by(id: params[:id])
      unless @patient
        redirect_to doctor_patients_path, alert: "Patient not found"
      end
    end

    def ensure_doctor!
      unless current_user.doctor?
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end
end
