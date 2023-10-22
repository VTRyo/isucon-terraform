locals {
  ami_ids = {
    # f=final, q=qualifier
    twelve-f = "ami-0ecfc02bf3af2d03e"
    twelve-q = "ami-073140ad092048333"
    eleven-f = "ami-00acaccebe03b5bed"
    eleven-q = "ami-0796be4f4814fc3d5"
    ten-f = "ami-0f7362c1bbc7e30ec"
    ten-q = "ami-03bbe60df80bdccc0"
    nine-f = "ami-07bf5a677677b826d"
    nine-q = "ami-03b1b78bb1da5122f"
    # 8以下は古いのでやらない
  }[var.isucon_version]
}

# TODO: 自分のSSH公開鍵を入力してください
resource "aws_key_pair" "main" {
  public_key = var.public_key
}


module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "isucon-${var.isucon_version}"

  instance_type               = "t2.micro"
  ami                         = "${local.ami_ids}"
  key_name                    = aws_key_pair.main.key_name
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Name = "isucon-${var.isucon_version}"
  }
}
