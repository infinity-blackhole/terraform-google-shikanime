resource "google_monitoring_notification_channel" "ingestion_developers_email" {
  display_name = "Shikanime Studio Engineering"
  type         = "email"
  project      = var.google_project
  labels = {
    email_address = var.support_email
  }
}
