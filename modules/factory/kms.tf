resource "google_kms_key_ring" "terraform" {
  project  = var.google_project
  name     = "terraform"
  location = var.google_region
  depends_on = [
    google_project_service.kms
  ]
}

resource "google_kms_crypto_key" "sensitive" {
  name            = "sensitive"
  key_ring        = google_kms_key_ring.terraform.id
  rotation_period = "86400s"
  purpose         = "ENCRYPT_DECRYPT"
}
