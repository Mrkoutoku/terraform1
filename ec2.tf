# ---------------------------
# EC2 Key pair
# ---------------------------
# 秘密鍵のアルゴリズム設定
resource "tls_private_key" "test_demo_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# クライアントPCにKey pair（秘密鍵と公開鍵）を作成
# - Windowsの場合はフォルダを"\\"で区切る（エスケープする必要がある）
# - [terraform apply] 実行後はクライアントPCの公開鍵は自動削除される
locals {
  public_key_file  = "./${var.key_name}.id_rsa.pub"
  private_key_file = "./${var.key_name}.id_rsa"
}
resource "local_file" "test_demo_key_pem" {
  filename = "${local.private_key_file}"
  content  = "${tls_private_key.test_demo_key.private_key_pem}"
}

# 上記で作成した公開鍵をAWSのKey pairにインポート
resource "aws_key_pair" "test_demo" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.test_demo_key.public_key_openssh}"
}

# ---------------------------
# EC2
# ---------------------------
# EC2作成
resource "aws_instance" "test_demo"{
  ami                         = "ami-03dceaabddff8067e"
  instance_type               = "t2.micro"
  availability_zone           = "${var.az_a}"
  vpc_security_group_ids      = [aws_security_group.test_demo.id]
  subnet_id                   = aws_subnet.test_demo.id
  key_name                    = "${var.key_name}"
  tags = {
    Name = "test-demo-ec2"
  }
}