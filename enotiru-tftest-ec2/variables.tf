variable "name" {
  description = "enotiru-tftest-ec2のインスタンスの名前です。" // 極力書く
  type        = string // 変数の型
  default     = "enotiru-tftest-ec2" // 値を定義
}

variable "instance_type" {
  description = "enotiru-tftest-ec2のinstance_typeです"
  type        = string
  default     = "t2.micro"
}
