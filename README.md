# Launch example
1. Configure AWS Profile ("AWS Access Key ID" _and_ "AWS Secret Access Key")
```sh
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export TF_VAR_public-key="*****"
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