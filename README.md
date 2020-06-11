# aws-terraform-ansible-demo
A demo to show how terraform and ansible can be used to deploy and manage an application (Wordpress in this case) and the associated infrastructure in AWS.\
With only a few basic pre-requisites, the terraform configuration will:\
-Create a VPC\
-Create subnets\
-Create route tables\
-Create security groups\
-Create Route53 DNS entries\
-Create a dev EC2 instance\
-Call Ansible to provision the dev instance with WordPress and necessary prerequisites\
-Create an S3 bucket and required IAM permissioning for application code\
-Create a golden AMI from dev for use in prod instances\
-Create prod EC2 instances\
-Create mysql RDS instance\
-Create an Elastic Load Balancer for prod\
-Create an autoscaling target group for the ELB\


There are a few primary things required to run this (note: there are many distributions of Linux which can affect the exact steps needed to setup your machine):
1. AWS account (temporary free account is fine)
 a. with an IAM account that has the AdministratorAccess policy and access keys used for AWS CLI config
 b. A Route53 reusable delegation set (more info below)
2. Provisoner computer running Linux (I used ubuntu 18.04) with the following installed and configured:
 a. AWS CLI (I used v2.0.15) and any prerequisites
  - when configuring the AWS CLI you will want to specify the profile using command: aws configure --profile <profilename>
 b. Terraform (I used v0.12.26) and any prerequisites
 c. Ansible (I used v2.5.1) and any prerequisites
  - with host_key_checking set to False (should be in /etc/ansible/ansible.cfg)
 d. Python, required by ansible (My machine had Python 2.7.17 which worked fine)
3. All of the above need to be callable from any directory, which may mean setting up your PATH
4. SSH key (public and private) for use in this demo
5. A registered domain that you can set the name servers. This is required for this demo as designed, there would be code changes required to get around this.

For dymanic DNS creation in Route53 use the reusable delegation set from AWS:
https://docs.aws.amazon.com/cli/latest/reference/route53/create-reusable-delegation-set.html
example: aws route53 create-reusable-delegation-set --caller-reference 1234

This will return name servers that you will need to add to your domain registrar.

----Running the Demo----\
First, clone the repo.\
Then, update the terraform.tfvars file as explained in the file's comments.\
Run "terraform init" to initialize\
Run "terraform plan" to run a check and handle any errors that arise\
Finally run "terraform apply" and wait for the prompt and type "yes" to let terraform set everything up (~10-15 mins)\
Once the terraform job is complete, you can go to your dev webserver: dev.<yourdomain.tld>/wp-admin/setup-config.php (Do not touch prod/www yet)\
You will have to run through the Wordpress setup, use the db config from terrafor.tfvars file.\
For the Database Host, you will need to look in Amazon RDS for the newly created db and copy the Endpoint name, paste that into the WP setup.\
Setup a WP admin user and pass of your choice.\

-Important-\
You must now go to Settings and for wordpress address(URL) and site address(URL) change to: http://www.<yourdomain.tld> for both and click save.\
(Note: If a message pops up notifying you that you do not have a wp-config.php file, its probably because you have been redirected to http://www.<yourdomain.tld>. Don't worry about this, you will not be able to access dev temporarily, proceed to the next step.)\
Before proceeding with any other changes, you must run the s3update.yml playbook in ansible to update the code for prod with this command: ansible-playbook -i aws_hosts s3update.yml\
You can now go back two dev.<yourdomain.tld>/wp-admin to log into the dev admin panel.
After 5 minutes or less, your prod instance will update automatically (check www.<yourdomain.tld> for the working webpage, do not use the admin panel in WP on prod.\

All changes should be made in dev and then use the s3update.yml ansible playbook to push changes to prod.\
That's it!\

To completly tear it all down use: terraform destroy


