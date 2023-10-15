terraform {
  backend "s3" {
    bucket = "theremotebackendofterraform-sudhamsh"
    key    = "eks-arbitary/terraform.tfstate"
    region = "us-west-2"
  }
}


