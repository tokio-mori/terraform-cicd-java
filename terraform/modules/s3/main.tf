resource "aws_s3_bucket" "artifact" {
  bucket = "${var.project_name}-artifact-${var.environment}"
  force_destroy = true

  tags = {
    name = "${var.project_name}-artifact"
  }
}