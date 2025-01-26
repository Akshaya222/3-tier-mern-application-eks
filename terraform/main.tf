module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "mern-app-eks-cluster"
  cluster_version = "1.26"

  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = "vpc-0851c744bb22df89a"
  subnet_ids = ["subnet-0c2d60c0427df37ad", "subnet-0799b96b7aaaeefe6", "subnet-0270072e78769766a"]

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_type = ["t2.small"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

resource "aws_iam_user" "cluster-manager" {
  name = "cluster-manager"
}

resource "aws_eks_access_entry" "manager-eks" {
  cluster_name      = "mern-app-eks-cluster"
  principal_arn     = aws_iam_user.cluster-manager.arn
  kubernetes_groups = ["my-admin"]
}