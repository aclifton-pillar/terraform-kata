provider "docker" {
  host = "tcp://192.168.99.100:2376/"
}

resource "docker_image" "nginx" {
  name = "nginx:1.11-alpine"
}

resource "docker_container" "nginx-server" {
  count = 1
  name = "nginx-server-${count.index+1}"
  image = "${docker_image.nginx.latest}"
  ports {
    internal = 80
  }
  volumes {
    container_path  = "/usr/share/nginx/html"
    host_path = "/home/scrapbook/tutorial/www"
    read_only = true
  }
}
