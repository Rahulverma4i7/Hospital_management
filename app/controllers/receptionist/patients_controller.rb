module Receptionist
  class PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_receptionist!
    before_action :set_patient, only: [ :show, :edit, :update, :destroy ]

    def index
      @patients = Patient.all
    end

    def show
    end

    def new
      @patient = Patient.new
    end

    def edit
    end

    def create
      @patient = Patient.new(patient_params)
      if @patient.save
        redirect_to receptionist_patient_path(@patient), notice: "Patient was successfully created."
      else
        render :new
      end
    end

    def update
      if @patient.update(patient_params)
        redirect_to receptionist_patient_path(@patient), notice: "Patient was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @patient.destroy
      redirect_to receptionist_patients_url, notice: "Patient was successfully deleted."
    end

    private

    def set_patient
      @patient = Patient.find_by(id: params[:id])
      unless @patient
        redirect_to receptionist_patients_path, alert: "Patient not found"
      end
    end

    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :dob, :gender, :phone, :address)
    end

    def ensure_receptionist!
      unless current_user.receptionist?
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end
end
