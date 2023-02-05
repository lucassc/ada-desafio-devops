resource "helm_release" "prometheus_operator" {
  name       = "prometheus"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kube-prometheus"
  version    = "8.1.2"

  namespace        = "monitoring"
  create_namespace = true

  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

