json.array!(@foos) do |foo|
  json.extract! foo, :id, :bar
  json.url foo_url(foo, format: :json)
end
