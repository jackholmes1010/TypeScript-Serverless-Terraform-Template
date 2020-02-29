#!/bin/bash

VERSION := $(shell git rev-parse HEAD)

default: check-vars build prepare-build copy-build select-workspace plan apply

check-vars:
ifndef ENVIRONMENT
	$(error ENVIRONMENT is not set)
endif

build:
	cd src && \
	tsc

prepare-build:
	cd src/js && \
	zip -r ../build.zip .

copy-build:
	aws s3 cp src/build.zip "s3://terraform-lambda-2/$(VERSION)/build.zip"

select-workspace:
	cd infra && \
	terraform workspace select ${ENVIRONMENT} || terraform workspace new ${ENVIRONMENT}

plan:
	cd infra && \
	terraform plan --var build_version=${VERSION} -var environment=${ENVIRONMENT} --out deployment.plan

apply:
	cd infra && \
	terraform apply deployment.plan

