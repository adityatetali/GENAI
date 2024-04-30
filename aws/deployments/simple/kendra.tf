resource "aws_iam_role_policy_attachment" "kendra_role_policy" {
    role        = aws_iam_role.kendra_role.name
    policy_arn  = aws_iam_policy.kendra_policy.arn
}

resource aws_security_group "kendra" {
    name        = "${local.identifier}-kendra-sg"
    description = "Allow access to Kendra from VPC Endpoint and authorized IP addresses"
    vpc_id      = data.aws_vpc.vpc.id
}