resource "k8s_core_v1_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

locals {
  parameters = {
    name                 = var.name
    namespace            = k8s_core_v1_namespace.this.metadata[0].name
    annotations          = var.annotations
    replicas             = var.replicas
    ports                = var.ports
    enable_service_links = false

    containers = [
      {
        name      = "registry"
        image     = var.image
        env       = var.env
        resources = var.resources
      },
    ]
  }
}

module "deployment-service" {
  source     = "git::https://github.com/mingfang/terraform-k8s-modules.git//archetypes/deployment-service"
  parameters = merge(local.parameters, var.overrides)
}