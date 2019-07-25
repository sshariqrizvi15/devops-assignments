output "test_vpc" {
  value = "${aws_vpc.test_vpc.id}"
}

output "test_public_sn_01" {
  value = "${aws_subnet.test_public_sn_01.id}"
}

output "test_public_sn_02" {
  value = "${aws_subnet.test_public_sn_02.id}"
}
output "test_public_sg" {
  value = "${aws_security_group.test_public_sg.id}"
}