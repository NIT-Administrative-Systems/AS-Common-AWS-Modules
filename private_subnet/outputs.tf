output "subnet_id_list" {
  value = ["${aws_subnet.subnet_az1.id}", "${aws_subnet.subnet_az2.id}"]
}
