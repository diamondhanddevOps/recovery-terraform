resource "aws_iam_role" "webserver" {
  name = "webserver-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "webserver" {
  name       = "webserver-policy-attachment"
  roles      = [aws_iam_role.webserver.name]
  policy_arn = "arn:aws:iam::717167831200:role/session_manager_role"
}

resource "aws_iam_policy_attachment" "s3" {
  name       = "s3-policy-attachment"
  roles      = [aws_iam_role.webserver.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role" "session_manager" {
  name = "session_manager_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "session_manager" {
  name = "session_manager_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2messages:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "session_manager" {
  name       = "session_manager_policy_attachment"
  policy_arn = aws_iam_policy.session_manager.arn
  roles      = [aws_iam_role.session_manager.name]
}

resource "aws_iam_policy" "s3" {
  name = "s3_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "bucket" {
  name       = "s3_policy_attachment"
  policy_arn = aws_iam_policy.s3.arn
  roles      = [aws_iam_role.session_manager.name]
}

resource "aws_ami" "golden-ami" {
  # ... other AMI properties
  name = "aws_iam_role.session_manager"

}