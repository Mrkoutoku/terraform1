# 作成したEC2のパブリックIPアドレスを出力
output "ec2_global_ips" {
  value = "${aws_instance.test_demo.*.public_ip}"
}
