class ServicesSettings < Settingslogic
  source Rails.root.join("config/services.yml").to_s
  namespace Rails.env
end
