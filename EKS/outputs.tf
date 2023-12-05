output "kubeconfig" {
  value       = module.eks_cluster.kubeconfig
  description = "Kubeconfig for EKS cluster"
}
