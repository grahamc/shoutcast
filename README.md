# ShoutCast

This repository has three components, all set to get you a running ShoutCast
instance.

## To just use the cloudformation step...

1. Edit `example_parameters.json` with the domain name you want to use (make sure it already exists in route53 first.)
2. Edit `example_parameters.json` to have the actual passwords you want
3. Run:

```
aws
    --region us-east-1
    cloudformation update-stack
    --capabilities CAPABILITY_IAM
    --stack-name ExampleShoutcastStack
    --template-body file://./cloudformation.json
    --parameters file://./example_parameters.json
```

## To make your own AMI (not required, the default AMI is public.)
**Note**: steps 1 and 2 can be done with `make ami` in the [Makefil](./Makefile).

1. Dockerfile: `docker build -t . shoutcast` will get you a usable docker
   container which will run shoutcast. Check out [start.sh](./start.sh) for
   details on how to configure, and what environment variables to use. Also
   see `icecast.xml` on how it is configured by default.

2. packer.json: `packer build packer.json` after building the Dockerfile,
   export the container via `docker save shoutcast | gzip > image.tar.gz` and
   run `AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY_ID= packer build
   packer.json`. This will start an AWS instance, configure it to run the
   image, and then create an AMI.

3. cloudformation.json: Create a stack with cloudformation (aws-cli could do
   this, or you could do it through the web interface ...) and enter the
   parameters. Use the AMI outputted in the previous step.

4. Stream!
