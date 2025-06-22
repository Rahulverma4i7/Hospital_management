json.extract! patient, :id, :first_name, :last_name, :dob, :gender, :phone, :address, :created_at, :updated_at
json.url patient_url(patient, format: :json)
