default_platform(:ios)

platform :ios do
  
  lane :register_app do
    produce(
      username: "bschick1@mac.com",
      app_identifier: "com.razeware.ChewChewTrain",
      app_name: "Chew Chew Train",
      team_name: "Brian Schick",
      itc_team_name: "Brian Schick"
    )
  end

  # lane :get_dev_certs do
  #   cert(development: true)
  #   sigh(development: true)
  # end 


  # desc "Sync Team Development assets"
  # lane :sync_all_development do
  #   match(type: "development")
  # end

  # desc "Sync Team Ad Hoc assets"
  # lane :sync_all_development do
  #   match(type: "adhoc")
  # end

  desc "Sync Team Code-Signing Assets"
  lane :sync_signing_assets do |options|
    # selectedType = options[:type]
    selectedType = options[:type].gsub(/[^a-z]/, '')
    match(type: selectedType)
  end
  
  desc "Update iOS UDID's on Developer Portal"
  lane :sync_device_info do
    register_devices(
      devices_file: "fastlane/Devicefile"
    )
  end

  desc "Build for App Store submission"
  lane :build_appstore do
    sync_signing_assets(type: "appstore")
    gym(
      output_directory: "build_AppStore",
      export_method: "app-store"
    )
  end

  desc "Build for Ad Hoc submission"
  lane :build_adhoc do
    sync_signing_assets(type: "adhoc")
    gym(
      output_directory: "build_AdHoc",
      export_method: "ad-hoc"
    )
  end


 
end