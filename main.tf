locals {
  lifecycle_rules = try(jsondecode(var.lifecycle_rules), var.lifecycle_rules)
  tags = try(jsondecode(var.tags), var.tags)
}

resource "yandex_storage_bucket" "bucket" {
  bucket = var.name
  default_storage_class = var.default_storage_class
  max_size = var.max_size
  access_key = var.access_key
  secret_key = var.secret_key

  versioning {
    enabled = var.versioning
  }

  anonymous_access_flags {
    read = var.anonymous_read
    list = var.anonymous_list
    config_read = var.anonymous_config_read
  }

  tags = local.tags

  dynamic "lifecycle_rule" {
    for_each = local.lifecycle_rules
    content {
      id = lifecycle_rule.key
      prefix = lookup(lifecycle_rule.value, "prefix", null)
      enabled = true
      dynamic "expiration" {
        for_each = lifecycle_rule.value.type == "expiration" ? { expiration = lifecycle_rule.value } : {}
        content {
          date = lookup(expiration.value, "date", null)
          days = lookup(expiration.value, "days", null)
          expired_object_delete_marker = lookup(expiration, "expired_object_delete_marker", null)
        }
      }
    }
  }
}