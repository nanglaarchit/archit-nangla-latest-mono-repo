aws_region      = "us-east-1"
network_name    = "prod-network"
vpc_cidr        = "10.1.0.0/16"
public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
azs             = ["us-east-1a", "us-east-1b"]

ec2_name      = "archit"
ami_id        = "ami-0f214d1b3d031dc53"
instance_type = "t3.medium"
sg_ingress = [
  { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
]
ebs_volumes = [
  { device_name = "/dev/sdb", volume_size = 20, volume_type = "gp3" },
  { device_name = "/dev/sdc", volume_size = 50, volume_type = "gp3" }
]

rds_name              = "archit-nangla-iac-training"
rds_password_ssm_name = "/rds/password"
allocated_storage     = 30
storage_type          = "gp3"
engine                = "mysql"
engine_version        = "8.0"
instance_class        = "db.t3.micro"
db_name               = "arciactraining"
db_username           = "archit"
db_port               = 3306
multi_az              = false
rds_sg_ingress        = [{ from_port = 3306, to_port = 3306, protocol = "tcp", cidr_blocks = ["10.1.1.0/24"] }]
