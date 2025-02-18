resource "aws_eks_cluster" "E-Commerce-Project" {
  name = "E-Commerce-Project"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster_ec.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.private.id
    ]
    security_group_ids = [ aws_security_group.eks_sg ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

resource "aws_eks_node_group" "ecomerce_nodes" {
  cluster_name    = aws_eks_cluster.E-Commerce-Project.name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.private.id]
  instance_types  = [var.eks_node_instance_type]
  
  
  
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  tags = {
    Name = "EKS-Node-Group"
  }
}