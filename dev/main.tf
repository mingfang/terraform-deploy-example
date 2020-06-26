module "springboot-docker" {
  source    = "./springboot-docker"
  name      = "cool-app"
  namespace = "cool-app"
  image     = var.springboot-docker-image
}