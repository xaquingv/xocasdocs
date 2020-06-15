# Driveshaft Changelog

## v1.0.0 - WIP

### Authentication

* Upgraded google-api-client gem
* Use [Default Application Credentials](https://developers.google.com/identity/protocols/application-default-credentials). `GOOGLE_APPLICATION_CREDENTIALS` takes the place of `GOOGLE_APICLIENT_SERVICEACCOUNT`. It must specify the service account json's path as opposed to its value.
* Other authentication methods deprecated:
  * `DRIVESHAFT_SETTINGS_AUTH_REQUIRED`
  * `DRIVESHAFT_SETTINGS_AUTH_DOMAIN`
  * `GOOGLE_APICLIENT_KEY`
  * `GOOGLE_APICLIENT_CLIENTSECRETS_INSTALLED`
  * `GOOGLE_APICLIENT_CLIENTSECRETS_WEB`

### Drive v3

* Driveshaft no longer uses an index json file to keep track of what to display on the homepage. Intead, a Google Team Drive folder should be specified, with the application's service account given read access. All files present in the folder will show up on the homepage in reverse chronological order.
  * Set `DRIVESHAFT_SETTINGS_INDEX_FOLDER` to the Drive Folder ID.
  * `DRIVESHAFT_SETTINGS_INDEX_DESTINATION` and `DRIVESHAFT_SETTINGS_INDEX_KEY` are both deprecated.

### Assets

* `npm` is used for asset management instead of `bower`.

### Home folder instead of index file

## v0.1.6 - 2016-07-22

* Fix for bug #28 around incorrectly convert Google Doc links to HTML.

## v0.1.5 - 2016-06-20

* Fixed Dockerfile reference to newsdev/kubernetes-secret-env.

## v0.1.4 - 2016-06-20

* Upgraded the archieml gem to support freeform arrays.

## v0.1.3 - 2015-12-09

* Updated Dockerfile to use a new base image from The New York Times.

## v0.1.2 - 2015-10-22

### Bugs

* Google OAuth2 settings should enable the "Google+ API", to enable accessing users' email addresses for identification.
* Added a [Troubleshooting guide](https://github.io/newsdev/driveshaft/reference/#troubleshooting) to the documentation.
* Force encoding of Google Spreadsheets to UTF-8 to avoid encoding errors from characters not in US-ASCII.

## v0.1.1 - 2015-05-28

### Features

* Added [app.json](https://devcenter.heroku.com/articles/app-json-schema) file for use with a Heroku Deploy Button

### Bugs

* #12: Gem upgrades: `rack v0.6.1` and `sinatra v1.4.6`

## v0.1.0 - 2015-05-27

Initial release.
