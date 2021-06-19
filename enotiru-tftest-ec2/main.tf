terraform {
  // バージョンを固定
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  // バックエンド設定には変数などは使えない
  // 固定文字列か別ファイルの注入になる
  backend "s3" {
    bucket = "enotiru-tftest" // 手動で予め作成する
    key    = "tfstate" // 手動で作らなくてもいい
    region = "ap-northeast-1"
  }
}

// デフォルトリージョン(東京)
provider "aws" {
  region = "ap-northeast-1"
  shared_credentials_file = "~/.aws/credentials"
  profile = "default"
}

// 外部データを検索条件を指定して参照できる
data "aws_ami" "ubuntu" {
 // 参照 https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
  most_recent = true // 複数の結果が返される場合は、最新のAMIを使用する

  // 検索に使用
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20200423"]
  }
  // 検索に使用 (なくてもいい)
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  // 検索に使用 AMIのオーナー
  owners = ["099720109477"]
}

// デプロイしたいリソースを定義
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id // dataから持ってきてる
  instance_type = var.instance_type
  // default VPCが設定されてない場合は以下を設定する
  // subnet_id = "subnet-019fzxxxxxxxxxx5"
  tags = {
    Name = var.name
  }
}
