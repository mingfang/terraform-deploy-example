variable "name" {}
variable "namespace" {}
variable "image" {}

variable "annotations" {
  default = {}
}
variable "replicas" {
  default = 1
}
variable "ports" {
  default = [
    {
      name = "http"
      port = 8080
    }
  ]
}
variable "env" {
  default = []
}
variable "resources" {
  default = {}
}
variable "overrides" {
  default = {}
}
