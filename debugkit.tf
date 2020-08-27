data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host = "https://${var.kubernetes_endpoint}"
    # Use OAuth bearer token short lived credential for the identity running
    # terraform.
    token    = data.google_client_config.default.access_token
    insecure = true
  }
}

provider "kubernetes" {
  host = "https://${var.kubernetes_endpoint}"
  # Use OAuth bearer token short lived credential for the identity running
  # terraform.
  token    = data.google_client_config.default.access_token
  insecure = true
}

resource "kubernetes_namespace" "create_keycloak_namespace" {
  metadata {
    name = var.keycloak_namespace
  }
}

# Debugkit only for testing purpose.
data "helm_repository" "debugkit_repository" {
  name = "debugkit"
  url  = "https://raw.githubusercontent.com/debek/k8s-debugkit/master"
}

resource "helm_release" "debugkit_helm" {
  name         = "debugkit"
  repository   = data.helm_repository.debugkit_repository.metadata.0.name
  chart        = "debugkit/debugkit"
  namespace    = var.keycloak_namespace
  force_update = "true"
  verify       = "false"
}
