terraform {
  backend "gcs" {
    bucket = "aef-shahcago-hackathon-tfe"
    prefix = "aef-data-transformation/environments/dev"
  }
}