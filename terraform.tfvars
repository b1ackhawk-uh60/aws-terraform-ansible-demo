#use the aws_profile here to specify a profile aws CLI. Required for this demo.
aws_profile = "<demoprofile>"
aws_region = "us-east-1"

vpc_cidr = "10.0.0.0/16"
cidrs    = {
  public1 = "10.0.1.0/24"
  public2 = "10.0.2.0/24"
  private1 = "10.0.3.0/24"
  private2 = "10.0.4.0/24"
  rds1 = "10.0.5.0/24"
  rds2 = "10.0.6.0/24"
  rds3 = "10.0.7.0/24"
}

#add your public IP of your local machine running ansible here.
#If you are running ansible on a remote machine, you may leave it 0.0.0.0/0
#to allow remote ansible access and browsing from local machine, but will be less secure
localip = "0.0.0.0/0"

#define your domain name below wrapped in quotes, as well as tld.
#seperate the domain and the top level domain(ie. .com, .net., org, etc.)
domain_name = "<yourdomain>"
tld = "<yourtld(i.e.,.com)>"

db_instance_class = "db.t2.micro"

#the below db values may be changed for security
dbname = "wordpressdb"
dbuser = "wordpressadmin"
dbpassword = "wpadminpass"

dev_instance_type = "t2.micro"
dev_ami = "ami-01d025118d8e760db"

#enter the public key location and filename that AWS should use
public_key_path = "</path/to/.ssh/yourkey.pub>"

#define the name below for the AWS key specified above
key_name = "<yourkey>"

#below values can be modified according to your elb and asg desires
elb_healthy_threshold = "2"
elb_unhealthy_threshold = "2"
elb_timeout = "3"
elb_interval = "30"
asg_max = "2"
asg_min = "1"
asg_grace = "300"
asg_hct = "EC2"
asg_cap = "2"
lc_instance_type = "t2.micro"

#add your delegation set below, wrapped in quotes
delegation_set = "<your delegation set string>"
