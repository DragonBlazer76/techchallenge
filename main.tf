provider "aws" {
  version = "~> 2.0"
  region  = "ap-southeast-1" # Setting my region to Singapore. Use your own region here
}

resource "aws_ecr_repository" "techchallenge_ecr_repo" {
  name = "techchallenge-ecr-repo" # Naming my repository
}
