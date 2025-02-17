output "jenkins_public_ip" {
  value = aws_instance.ec2_jenkinsinstance.public_ip
  description = "Public IP of the Jenkins instance"
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.E-Commerce-Project.endpoint
  description = "eks cluster endpoint"
}

output "eks_cluster_name" {
  value = aws_eks_cluster.E-Commerce-Project.name
  description = "ekx cluster name"
}