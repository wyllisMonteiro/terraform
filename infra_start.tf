# Configure the AWS Provider
provider "aws" {
    region                  = "eu-west-2"
    shared_credentials_file = "/Users/tf_user/.aws/creds"
    profile                 = "wyllis"
}

# Create a new instance
resource "aws_instance" "application" {
    # Go to AWS to create AMI
    ami = “xxxxxxxxxx”
    count = “1”
    instance_type = “t2.micro”
    tags {
        Name = “application”
    }
}

# Create an autoscaling group
resource "aws_autoscaling_group" "autoscale_group" {
  name                      = "autoscale"
  max_size                  = 5
  min_size                  = 2
  health_check_type         = "EC2"
  force_delete              = true
  load_balancers            = ["${aws_elb.lb_elb}"]
  tag {
    key = "Name"
    value = "load_balancer"
  }
}