provider "aws" {
  # version = "~> 2.0"
   region  = "sa-east-1"
}

provider "aws" {
   alias   = "us-east-2"
  # version = "~> 2.0"
   region  = "us-east-2"
}

resource "aws_instance" "dev" {
    count         = 2
    ami           = var.amis["sa-east-1"] # id da imagem na aws
    instance_type = var.instance_type
    key_name      = var.key_name # nome da chave ssh criada na aws 
    tags = {
        Name      = "dev${count.index}" # marcador aos recursos utlizados 
    }
    vpc_security_group_ids = [aws_security_group.ssh-acesso.id] #id do vpc, informado no console
}

resource "aws_instance" "dev3" {
    ami           = var.amis["sa-east-1"] # id da imagem na aws
    instance_type = var.instance_type
    key_name      = var.key_name # nome da chave ssh criada na aws 
    tags = {
        Name      = "dev3" # marcar aos recursos utlizados 
    }
    vpc_security_group_ids = [aws_security_group.ssh-acesso.id] #id do vpc, informado no console
    depends_on     = [aws_s3_bucket.bucket-dev3]
}


resource "aws_instance" "dev4" {
    provider      = aws.us-east-2
    ami           = var.amis["us-east-2"] # id da imagem na aws outra zona
    instance_type = var.instance_type
    key_name      = var.key_name # nome da chave ssh criada na aws 
    tags = {
        Name      = "dev4" # marcar aos recursos utlizados 
    }
    vpc_security_group_ids = [aws_security_group.ssh-acesso-us-east-2.id] #id do vpc, informado no console
    depends_on     = [aws_dynamodb_table.dynamodb-table-hm]
}


resource "aws_s3_bucket" "bucket-dev3" { 
  bucket = "alura-bucket-dev3" # s3 armazenamento
  acl    = "private"

  tags = {
    Name = "alura-bucket-dev3"
  }
}

resource "aws_dynamodb_table" "dynamodb-table-hm" {
  provider    =  aws.us-east-2
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}