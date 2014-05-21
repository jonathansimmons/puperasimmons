json.array!(@tasks) do |task|
  json.extract! task, :id, :content, :completed, :due_date, :contact_id, :user_id, :contact_sort, :main_sort, :uid
  json.url task_url(task, format: :json)
end
