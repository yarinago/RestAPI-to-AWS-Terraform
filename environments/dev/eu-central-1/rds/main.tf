#resource "aws_db_instance" "rds_instance" {
#    allocated_storage = 20
#    identifier = "rds-terraform"
#    storage_type = "gp2"
#    engine = "postgresql"
#    engine_version = "13.7"
#    instance_class = "db.t3.micro"
#    username = "user"
#    password = "pass"
#    publicly_accessible = false 
#    skip_final_snapshot = true # Disable taking a final backup when you destroy the database
#     
#
#    tags = {
#        Name = "ExampleRDSServerInstance"
#        }
#}