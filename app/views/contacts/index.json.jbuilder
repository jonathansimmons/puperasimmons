json.array!(@contacts) do |contact|
  json.extract! contact, :id, :type, :transaction_type, :status, :name, :email, :phone, :company, :street, :city, :state, :postal_code, :service, :loop_id
  json.url contact_url(contact, format: :json)
end
