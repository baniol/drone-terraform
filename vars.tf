variable "region" {
  description = "Region to deploy to"
}

variable "drone_host" {
  description = "DNS for Drone"
}

variable "path_to_public_key" {
  description = "Path to a public key to upload to AWS for SSH access"
}

# TODO import zone
variable "zoneID" {
  description = "ID of the Hosted Zone for Drone DNS"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "amis" {
  default = {
    us-east-2      = "ami-956e52f0"
    us-east-1      = "ami-5253c32d"
    us-west-2      = "ami-d2f489aa"
    us-west-1      = "ami-6b81980b"
    eu-west-3      = "ami-ca75c4b7"
    eu-west-2      = "ami-3622cf51"
    eu-west-1      = "ami-c91624b0"
    eu-central-1   = "ami-10e6c8fb"
    ap-northeast-2 = "ami-7c69c112"
    ap-northeast-1 = "ami-f3f8098c"
    ap-southeast-2 = "ami-bc04d5de"
    ap-southeast-1 = "ami-b75a6acb"
    ca-central-1   = "ami-da6cecbe"
    ap-south-1     = "ami-c7072aa8"
    sa-east-1      = "ami-a1e2becd"
  }

}

variable "github_client" {
  description = "Github Client ID"
}

variable "github_secret" {
  description = "Github Client Secret"
}

variable "min_size" {
  description = "Minimum size of the Autoscaling Group"
}

variable "max_size" {
  description = "Maximum size of the Autoscaling Group"
}

variable "desired_capacity" {
  description = "Desired capacity of the Autoscaling Group"
}
