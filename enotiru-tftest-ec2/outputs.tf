// outputでaaply時にcosoleに表示される
output "enotiru-tftest-ec2" {
  // resourceの単位でoutputできる
  // ${resource_type}.${resource_name}.${argument_name}でする
  //（v0.12.0以降は、${argument_name}を省略するとresource全体をoutputできます)
  value = aws_instance.web
}
