terraform {
    backend "s3" {
        bucket = "aitfs3"
        key    = "tfstate/simplevirginia-dev-ai.tfstate"
        region = "us-east-1"
    }
}