resource "aws_iam_role" "role" {
    name               = var.iam_role_name
    description        = var.iam_role_description

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": 
    [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}

EOF
}

resource "aws_iam_policy" "policy" {
    name        = var.iam_policy_name
    description = var.iam_policy_description

    policy      = <<EOF
{
    	"Version": "2012-10-17",
    	"Statement": [
        	{
            		"Effect": "Allow",
            		"Action": [
                		"logs:CreateLogGroup",
                		"logs:CreateLogStream",
              		  "logs:PutLogEvents"
          		  ],
           		 "Resource": "arn:aws:logs:*:*:*"
     	   },
        	   {
            		"Effect": "Allow",
           		"Action": [
                		"ec2:DescribeInstances",
                		"ec2:DescribeRegions",
                		"ec2:StartInstances",
                		"ec2:StopInstances"
           	 	],
            		"Resource": "*"
        	         }
    	     ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "this" {
    role       = aws_iam_role.role.name
    policy_arn = aws_iam_policy.policy.arn
}
