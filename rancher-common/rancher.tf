# Rancher resources

# Initialize Rancher server
resource "rancher2_bootstrap" "admin" {
  depends_on = [
    helm_release.rancher_server
  ]

  provider = rancher2.bootstrap

  password  = var.admin_password
  telemetry = true
}

# Create custom managed cluster for cise
resource "rancher2_cluster" "cise_workload" {
  provider = rancher2.admin

  name        = var.workload_cluster_name
  description = "Custom workload cluster created by the Terraform script."

  rke_config {
    network {
      plugin  = var.rke_network_plugin
      options = var.rke_network_options
    }
    kubernetes_version = var.workload_kubernetes_version
  }
  windows_prefered_cluster = var.windows_prefered_cluster
}
