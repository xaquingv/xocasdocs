require 'rubygems'
require 'bundler'
Bundler.require

require 'rack'
require 'json'
require 'aws-sdk'
require 'google/api_client/client_secrets'

# Parse environmental variables

$settings = {
  index: {
    destination: ENV['DRIVESHAFT_SETTINGS_INDEX_DESTINATION'],
    key: ENV['DRIVESHAFT_SETTINGS_INDEX_KEY']
  },
  auth: {
    required: ENV['DRIVESHAFT_SETTINGS_AUTH_REQUIRED'].to_s == 'true',
    domain: ENV['DRIVESHAFT_SETTINGS_AUTH_DOMAIN']
  },
  asset_host: (ENV['DRIVESHAFT_SETTINGS_ASSET_HOST'] || '/assets').sub(/\/$/, ''),
  max_versions: ENV['DRIVESHAFT_SETTINGS_MAX_VERSIONS'].to_i,
  session_secret: ENV['DRIVESHAFT_SETTINGS_SESSION_SECRET'] || 'secret'
}

$google_service_account = if service_path = ENV['GOOGLE_APICLIENT_SERVICEACCOUNT']
  begin  JSON.load(File.read(File.expand_path(service_path)));
  rescue; JSON.load(service_path); end
end

# Either an "installed" / "native application" OR "web application" client
# JSON can be active at once. Each requires client-side OAuth2.
$google_client_secrets_installed = if secrets_path = ENV['GOOGLE_APICLIENT_CLIENTSECRETS_INSTALLED']
  begin  Google::APIClient::ClientSecrets.load(File.expand_path(secrets_path));
  rescue; Google::APIClient::ClientSecrets.new(JSON.load(secrets_path)); end
end
$google_client_secrets_installed_cache = File.expand_path(ENV['GOOGLE_APICLIENT_FILESTORAGE'] || '~/.google_drive_oauth2.json')

$google_client_secrets_web = if !$google_client_secrets_installed && secrets_path = ENV['GOOGLE_APICLIENT_CLIENTSECRETS_WEB']
  begin  Google::APIClient::ClientSecrets.load(File.expand_path(secrets_path));
  rescue; Google::APIClient::ClientSecrets.new(JSON.load(secrets_path)); end
end

$google_client_key = ENV['GOOGLE_APICLIENT_KEY']

if ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY'] && ENV['AWS_REGION']
  $s3           = Aws::S3::Client.new
  $s3_resources = Aws::S3::Resource.new
  $s3_presigner = Aws::S3::Presigner.new
end

require './lib/driveshaft'
require './lib/driveshaft/app'
require './lib/driveshaft/auth'

run Driveshaft::App.new
