data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [ "ec2.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = {
    name = "EC2Role"
  }
}

# --- ECRへのアクセス許可 ---
# Amazonが管理しているECRへの読み取り専用ポリシーを参照
data "aws_iam_policy" "ecr_read_only" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# ECR読み取り専用ポリシーをIAMロール（EC2）にアタッチ
resource "aws_iam_role_policy_attachment" "ecr_read_only_attachment" {
  role = aws_iam_role.ec2-role.name
  policy_arn = data.aws_iam_policy.ecr_read_only.arn
}

# SSMとCloudWatch Agentの権限をEC2にアタッチ
data "aws_iam_policy" "ssm_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_core_attachment" {
  role = aws_iam_role.ec2-role.name
  policy_arn = data.aws_iam_policy.ssm_core.arn
}

data "aws_iam_policy" "cloud_watch_agent" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "cloud_watch_agent_attachment" {
  role = aws_iam_role.ec2-role.name
  policy_arn = data.aws_iam_policy.cloud_watch_agent.arn
}

# --- CloudWatchへのアクセス許可 ---
# Amazonが管理しているCloudWatch Agent用のポリシーを参照
data "aws_iam_policy" "cloudwatch_agent_server" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# CloudWatchエージェントポリシーをIAMロール（EC2）にアタッチ
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_attachment" {
  role = aws_iam_role.ec2-role.name
  policy_arn = data.aws_iam_policy.cloudwatch_agent_server.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2-role.name
}
