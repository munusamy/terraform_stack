variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "instance_size" {
  type    = "string"
  default = "t2.micro"
}

variable "elb_az" {
  type = "list"
  default = ["us-west-1b", "us-west-1c"]
}
variable "subnet_cidr_pub" {
  type = "map"

  default = {
    "us-west-1b" = "10.0.1.0/24"
    "us-west-1c" = "10.0.5.0/24"
  }
}

variable "subnet_cidr_pvt" {
  type = "map"

  default = {
    "us-west-1b" = "10.0.2.0/24,10.0.3.0/24,10.0.4.0/24"
    "us-west-1c" = "10.0.6.0/24,10.0.7.0/24,10.0.8.0/24"
  }
}

variable "subnet_pub_tag" {
  type = "map"

  default = {
    "us-west-1b" = "bastion_1b"
    "us-west-1c" = "bastion_1c"
  }
}

variable "common_instance_linux" {
  type = "map"

  default = {
    "us-west-1b" = "Jenkins_1b,Jira_1b,Artifactory_1b,Bitbucket_1b,Confluence_1b"
    "us-west-1c" = "Jenkins_1c,Jira_1c,Artifactory_1c,Bitbucket_1c,Confluence_1c"
  }
}

variable "common_instance_windows" {
  type = "map"

  default = {
    "us-west-1b" = "Active_Directory_1b,TFS_Server_1b,eBuild_1b,DFS_Server_1b"
    "us-west-1c" = "Active_Directory_1c,TFS_Server_1c,eBuild_1c,DFS_Server_1c"
  }
}

variable "linux_ins_count" {
  default = "5"
}

variable "windows_ins_count" {
  default = "4"
}

variable "linux_user" {
  default = "centos"
}

variable "windows_user" {
  default = "Administrator"
}

variable "linux_ami" {
  type = "map"

  default = {
    "Jenkins_1b" = "ami-05f3b465"
    "Jira_1b" = "ami-05f3b465"
    "Artifactory_1b" = "ami-05f3b465"
    "Bitbucket_1b" = "ami-05f3b465"
    "Confluence_1b" = "ami-05f3b465"
    "Jenkins_1c" = "ami-05f3b465"
    "Jira_1c" = "ami-05f3b465"
    "Artifactory_1c" = "ami-05f3b465"
    "Bitbucket_1c" = "ami-05f3b465"
    "Confluence_1c" = "ami-05f3b465"
  }
}

variable "windows_ami" {
  type = "map"

  default = {
    "Active_Directory_1b" = "ami-65c7ec05"
    "TFS_Server_1b" = "ami-65c7ec05"
    "eBuild_1b" = "ami-65c7ec05"
    "DFS_Server_1b" = "ami-65c7ec05"
    "Active_Directory_1c" = "ami-65c7ec05"
    "TFS_Server_1c" = "ami-65c7ec05"
    "eBuild_1c" = "ami-65c7ec05"
    "DFS_Server_1c" = "ami-65c7ec05"
  }
}

variable "subnet_pvt_tag" {
  type = "map"

  default = {
    "us-west-1b" = "web_subnet_1b,app_subnet_1b,db_subnet_1b"
    "us-west-1c" = "web_subnet_1c,app_subnet_1c,db_subnet_1c"
  }
}

variable "layers_pvt_count" {
  type    = "string"
  default = "3"
}

variable "layers_pub_count" {
  type    = "string"
  default = "1"
}

variable "aws_amis" {
  description = "AMI-ID for Bastion Hosts."
  type        = "map"

  default = {
    "us-west-1" = "ami-05f3b465"
  }
}

variable "aws_keyname" {
  description = "aws pem_key to login to the server"
  default     = "PJ"
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
