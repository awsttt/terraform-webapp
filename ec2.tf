resource "aws_instance" "my_app_eg1" {
  for_each = local.web_servers

  ami           = "ami-0c4c4bd6cf0c5fe52"
  instance_type = each.value.machine_type
  key_name      = "aaaaa"
  subnet_id     = each.value.subnet_id

  vpc_security_group_ids = [aws_security_group.ec2_eg1.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  sudo systemctl start httpd
  echo "Hello world" > /var/www/html/test.html
  echo "*** Completed Installing apache2"
  echo "*** Installing NFS Utils"
  sudo yum -y install nfs-utils
  #!/bin/bash
              mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs-example.dns_name}:/ /your/mount/point/
  EOF

  tags = {
    Name = each.key
  }
}
