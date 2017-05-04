# Launch example
1. Configure AWS Profile ("AWS Access Key ID" _and_ "AWS Secret Access Key")
```sh
aws configure --profile=${PROFILE_NAME}
```
2. Import modules
```sh
terraform get
```
3. Display execution plan
```sh
terraform plan
```
4. Deploy
```sh
terraform apply
```