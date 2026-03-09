# Provider (Google Cloud)
provider "google" {
  project = "project-508b67ba-bc4a-4c1c-9dc"
  region  = "us-central1"
}

# Necessary APIs
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

# GKE Autopilot Cluster
resource "google_container_cluster" "primary" {
  name     = "online-boutique-tf"
  location = "us-central1"

  deletion_protection = false

  enable_autopilot = true

  depends_on = [google_project_service.container]
}

# Artifact Registry API
resource "google_project_service" "artifactregistry" {
  service = "artifactregistry.googleapis.com"
}

# Docker Repository
resource "google_artifact_registry_repository" "boutique_repo" {
  location      = "us-central1"
  repository_id = "boutique-repo"
  description   = "Docker repository for Online Boutique images"
  format        = "DOCKER"

  depends_on = [google_project_service.artifactregistry]
}