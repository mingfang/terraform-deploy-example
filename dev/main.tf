module "springboot-docker" {
  source    = "./springboot-docker"
  name      = "springboot-docker"
  namespace = "springboot-docker"
  image     = var.springboot-docker-image
}