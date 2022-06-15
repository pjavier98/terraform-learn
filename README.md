
# Instructions to run

* To run development environment:

```
terraform apply -var-file "terraform-dev.tfvars"
```

* To run staging environment:

```
terraform apply -var-file "terraform-staging.tfvars"
```

* To run production environment:

```
terraform apply -var-file "terraform-production.tfvars"
```

![terraform image](./doc/terraform.jpg)

## Best Practices with Terraform

1. Manipulate state only through TF commands

2. Always set up a shared remote storage for the **tfstate** file

3. Use state locking (S3 supports state locking and consistency checking via DynamoDB)

4. Back up your state file! (enable versioning)

5. Use 1 **tfstate** file per environment

6. Host TF scripts in Git repository

7. Treat TF Code just like your Application Code (CI for Terraform Code)

8. Execute Terraform in a automated build (Apply Infraestruture Changes Only through CD pipeline)
