resource "k8s_core_v1_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

module "springboot" {
  source = "git::https://github.com/mingfang/terraform-k8s-modules.git//archetypes/deployment-service"
  parameters = {
    name                 = var.name
    namespace            = k8s_core_v1_namespace.this.metadata[0].name
    annotations          = var.annotations
    replicas             = var.replicas
    ports                = var.ports
    enable_service_links = false

    containers = [
      {
        name      = "springboot"
        image     = var.image
        env       = var.env
        resources = var.resources
      },
    ]
  }
}

resource "k8s_networking_k8s_io_v1beta1_ingress" "this" {
  metadata {
    annotations = {
      "kubernetes.io/ingress.class"              = "nginx"
      "nginx.ingress.kubernetes.io/server-alias" = "springboot.*"
    }
    name      = module.springboot.name
    namespace = k8s_core_v1_namespace.this.metadata[0].name
  }
  spec {
    rules {
      host = "${module.springboot.name}-${var.namespace}"
      http {
        paths {
          backend {
            service_name = module.springboot.name
            service_port = module.springboot.service.spec[0].ports[0].port
          }
          path = "/"
        }
      }
    }
  }
}
