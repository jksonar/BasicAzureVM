locals {
  name_prefix = "${var.prefix}-${var.environment}"

  common_tags = merge({
    project     = var.prefix
    environment = var.environment
    managed_by  = "terraform"
  }, var.tags)
}
