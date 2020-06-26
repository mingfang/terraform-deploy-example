module "springboot-docker" {
  source    = "./springboot-docker"
  name      = "springboot-docker"
  namespace = var.environment
  image     = var.springboot-docker-image
}