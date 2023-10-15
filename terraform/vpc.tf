module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "main"
  cidr = "10.0.0.0/16"

  azs             = var.availability_zones
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"] #application and data server run inside the private subnets
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"] #for the load balancer we gonna provision the public subnets

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  enable_nat_gateway     = true # the pod inside the private subnet need to access the ecr repo to pull the image
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "dev"
  }
}

# this is did by sudhamsh, pulled from terraform modules for checkout kinda stuff
# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.1.2"
# }