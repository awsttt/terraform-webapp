resource "aws_efs_file_system" "efs-example" {
  creation_token   = "efs-example"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "EfsTest"
  }
}

resource "aws_efs_mount_target" "efs-example" {
  file_system_id  = aws_efs_file_system.efs-example.id
  subnet_id       = aws_subnet.subnet-efs.id
  security_groups = aws_security_group.ingress_efs_traffic.id
}

