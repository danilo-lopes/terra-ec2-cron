provider "aws" {
    region                  = "foo"

    shared_credentials_file = "/home/bar/.aws/credentials"
    profile                 = "foo-bar"
}
