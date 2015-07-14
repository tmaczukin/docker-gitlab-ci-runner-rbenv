tstamp = $(shell date +"%Y%m%d%H%M%S")
tag = 0.1
name = gitlab-ci-runner-rbenv
vendor = tmaczukin
imageName = $(vendor)/$(name)

build: Dockerfile
	docker build --rm -t $(imageName):$(tag) .

vupdate: Dockerfile
	sed -i "s/# update_[0-9]*/# update_$(tstamp)/" Dockerfile

ubuild: vupdate build
