image:
	docker build -t shoutcast .

image.tar.gz: image
	docker save shoutcast | gzip -9 > image.tar.gz

ami: image.tar.gz
	packer build packer.json
