variable "name" {
  default = "myoneandonlystaticbucket"
}

variable "environment" {
  default   = "test"
  sensitive = true
}

variable "files" {
  default = "./html"
}

variable "file" {
  default = "index.html"
}