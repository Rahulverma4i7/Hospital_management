module Receptionist
  class PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_patient, only: [ :show, :edit, :update, :destroy ]
    before_action :ensure_receptionist!

   # GET /receptionist/patients
   def index
  @patients = Patient.all.order(created_at: :desc)

  # Get registration data for the last 30 days
  date_range = (Date.today - 29.days)..Date.today
  @registration_data = Patient
    .group_by_day(:created_at, range: date_range, format: "%b %d")
    .count
    .transform_values(&:to_i)
   end
    # GET /receptionist/patients/1
    def show
    end

    # GET /receptionist/patients/new
    def new
      @patient = Patient.new
    end

    # GET /receptionist/patients/1/edit
    def edit
    end

    # POST /receptionist/patients
    def create
      @patient = Patient.new(patient_params)

      if @patient.save
        redirect_to receptionist_patient_path(@patient), notice: "Patient was successfully created."
      else
        render :new
      end
    end

    # PATCH/PUT /receptionist/patients/1
    def update
      if @patient.update(patient_params)
        redirect_to receptionist_patient_path(@patient), notice: "Patient was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /receptionist/patients/1
    def destroy
      @patient.destroy
      redirect_to receptionist_patients_url, notice: "Patient was successfully destroyed."
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_patient
        @patient = Patient.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def patient_params
        params.require(:patient).permit(:first_name, :last_name, :dob, :gender, :phone, :address)
      end

      def ensure_receptionist!
        unless current_user.receptionist?
          redirect_to root_path, alert: "You are not authorized to access this page."
        end
        def create_sample_data
  # Same data creation code as in step 1
  redirect_to doctor_patients_path, notice: "Sample data created successfully"
        end
      end
  end
end
