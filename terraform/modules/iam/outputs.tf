output "instance_profile_name" {
  description = "IAM instance profile for the EC2 server"
  value = aws_iam_instance_profile.ec2_instance_profile.name
}