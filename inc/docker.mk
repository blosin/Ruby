ifndef INTERNAL_REGISTRY_URL
INTERNAL_REGISTRY_URL=nexus.ascentio.com.ar:7443
endif

ifndef TARGET
	ifndef IMAGE_VERSION
		IMAGE_VERSION := $(shell grep -e "LABEL VERSION=" Dockerfile | cut -d ' ' -f 2 | cut -d '=' -f 2 | cut -d '"' -f 2)
		ifndef IMAGE_VERSION
			IMAGE_VERSION=latest
		endif
	endif
else
	ifndef IMAGE_VERSION
		IMAGE_VERSION=${TARGET}-latest
	endif
	TARGET_COMMAND := --target ${TARGET}
endif



pre-build-image:

pull-images:
	@if [ -z $(TARGET) ] ; \
	then \
		echo "Trying to pull FROM image from internal registry: ${INTERNAL_REGISTRY_URL}"; \
		grep -e FROM Dockerfile | cut -d ' ' -f 2 | xargs -I {} bash -c "docker pull ${INTERNAL_REGISTRY_URL}/{} || echo \"{} image not found on ${INTERNAL_REGISTRY_URL}\""; \
		echo "Trying to re-tag images from registry as local"; \
		grep -e FROM Dockerfile | cut -d ' ' -f 2 | xargs -I {} bash -c "docker tag ${INTERNAL_REGISTRY_URL}/{} {} || echo \"${INTERNAL_REGISTRY_URL}/{} image not found, not re-tagging\""; \
	else \
		echo "Trying to pull FROM image from internal registry: ${INTERNAL_REGISTRY_URL}"; \
		grep -e "AS ${TARGET}" Dockerfile | cut -d ' ' -f 2 | xargs -I {} bash -c "docker pull ${INTERNAL_REGISTRY_URL}/{} || echo \"{} image not found on ${INTERNAL_REGISTRY_URL}\""; \
		echo "Trying to re-tag images from registry as local"; \
		grep -e "AS ${TARGET}" Dockerfile | cut -d ' ' -f 2 | xargs -I {} bash -c "docker tag ${INTERNAL_REGISTRY_URL}/{} {} || echo \"${INTERNAL_REGISTRY_URL}/{} image not found, not re-tagging\""; \
	fi;

build-image-locally:
	docker build ${BUILD_OPTS} --build-arg https_proxy=${HTTPS_PROXY} --build-arg http_proxy=${HTTP_PROXY} \
					--label builton=$$(hostname) --label builtby=$$(whoami) --label version=${IMAGE_VERSION} \
					--label commit=$$(echo $$(git rev-parse HEAD)$$(git diff --quiet || echo '-dirty')) \
					${TARGET_COMMAND} --tag ${IMAGE}:${IMAGE_VERSION} .
build-image: pull-images pre-build-image build-image-locally
build-image-with-local-cache: pull-images pre-build-image
	$(MAKE) build-image HTTP_PROXY=http://172.17.0.1:3128 HTTPS_PROXY=http://172.17.0.1:3128
build-image-locally-with-local-cache: pull-images pre-build-image
	$(MAKE) build-image-locally HTTP_PROXY=http://172.17.0.1:3128 HTTPS_PROXY=http://172.17.0.1:3128
push-image: build-image
	docker tag ${IMAGE}:${IMAGE_VERSION} ${INTERNAL_REGISTRY_URL}/${IMAGE}:${IMAGE_VERSION}
	docker push ${INTERNAL_REGISTRY_URL}/${IMAGE}:${IMAGE_VERSION}

ifndef ENTRYPOINT
ENTRYPOINT=/bin/bash
endif
enter-image:
	docker run --rm -it --entrypoint ${ENTRYPOINT} ${IMAGE}:${IMAGE_VERSION}

lint-image:
	@echo 'More about Hadolint rules: https://github.com/hadolint/hadolint#rules'
	@echo 'RUN instructions are analyzed with Shellcheck: https://github.com/koalaman/shellcheck/wiki'
	@echo 'Bulding images best practices: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#sort-multi-line-arguments'

	docker run --rm -i hadolint/hadolint:v1.23.0 < Dockerfile
show-image-metadata:
	docker inspect --format '{{ .Config.Labels  }}' ${IMAGE}:${IMAGE_VERSION}
