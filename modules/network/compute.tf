resource "google_compute_global_address" "shikanime_studio" {
  project    = var.google_project
  name       = "shikanime-studio"
  ip_version = "IPV4"
}

resource "google_compute_global_forwarding_rule" "shikanime_studio_http" {
  project    = var.google_project
  name       = "shikanime-studio-http"
  target     = google_compute_target_http_proxy.shikanime_studio.self_link
  ip_address = google_compute_global_address.shikanime_studio.address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "shikanime_studio_https" {
  project    = var.google_project
  name       = "shikanime-studio-https"
  target     = google_compute_target_https_proxy.shikanime_studio.self_link
  ip_address = google_compute_global_address.shikanime_studio.address
  port_range = "443"
}

resource "google_compute_target_http_proxy" "shikanime_studio" {
  project = var.google_project
  name    = "shikanime-studio"
  url_map = google_compute_url_map.shikanime_studio.name
}

resource "google_compute_target_https_proxy" "shikanime_studio" {
  project          = var.google_project
  name             = "shikanime-studio"
  ssl_certificates = [google_compute_managed_ssl_certificate.shikanime_studio.id]
  url_map          = google_compute_url_map.shikanime_studio.name
}

resource "google_compute_managed_ssl_certificate" "shikanime_studio" {
  project = var.google_project
  name    = "shikanime-studio"
  managed {
    domains = ["shikanime.studio"]
  }
}

resource "google_compute_url_map" "shikanime_studio" {
  project         = var.google_project
  name            = "shikanime-studio"
  default_service = google_compute_backend_service.shikanime_studio.id
}

resource "google_compute_backend_service" "shikanime_studio" {
  project = var.google_project
  name    = "shikanime-studio"
}
