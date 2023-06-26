variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "name" {
  type = string
}

variable "default_storage_class" {
  default = "STANDARD" # "COLD", "ICE"
}

variable "max_size" {
  default = 0
}

variable "versioning" {
  default = false
}

variable "anonymous_read" {
  default = false
}

variable "anonymous_list" {
  default = false
}

variable "anonymous_config_read" {
  default = false
}

variable "lifecycle_rules" {
  default = {
    # {
    #   id = null
    #   prefix = null
    #   expiration = {
    #     date = null
    #     days = null
    #     expired_object_delete_marker = null
    #   }
    # }
  }
}

variable "tags" {
  default = {}
}