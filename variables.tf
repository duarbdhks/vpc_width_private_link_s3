variable "region" {
  default = "ap-northeast-2"
}

variable "profile" {
  default = "default"
}

variable "public_instance" {
  type    = string
  default = "ami-0a93a08544874b3b7"
}

variable "private_instance" {
  type    = string
  default = "ami-0a93a08544874b3b7"
}

variable "availabilityZonePub" {
  default = "ap-northeast-2a"
}

variable "availabilityZonePriv" {
  default = "ap-northeast-2c"
}

variable "instanceTenancy" {
  default = "default"
}

variable "dnsSupport" {
  default = true
}

variable "dnsHostNames" {
  default = true
}

variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}

# private subnet
variable "subnetCIDRblock1" {
  default = "10.0.0.0/24"
}

# public subnet
variable "subnetCIDRblock2" {
  default = "10.0.1.0/24"
}

variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}

variable "ingressCIDRblockPriv" {
  type    = string
  default = "10.0.1.0/24"
}

variable "ingressCIDRblockPub" {
  type    = string
  default = "0.0.0.0/0"
}

variable "mapPublicIP" {
  default = true
}

variable "bucket_name" {
  type    = string
  default = "tfendpoint"
}

variable "key_name" {
  type    = string
  default = "yeumkey"
}