IMAGE_NAME=depoco
TAG=latest
DATASETS=/yuan/cmj/data/kitti/sequences

build:
	@echo Building docker container $(IMAGE_NAME)
	docker run --rm --runtime=nvidia --gpus all build -t $(IMAGE_NAME):$(TAG) .

test:
	@echo NVIDIA and CUDA setup
	@nvidia-docker run --rm $(IMAGE_NAME):$(TAG) nvidia-smi
	@echo PytTorch CUDA setup installed?
	@nvidia-docker run --rm $(IMAGE_NAME):$(TAG) python3 -c "import torch; print(torch.cuda.is_available())"

run:
	docker run --rm --gpus "device=1" -p 8888:8888 -it -v $(DATASETS):/data $(IMAGE_NAME)

clean:
	@echo Removing docker image...
	-docker image rm --force $(IMAGE_NAME):$(TAG)
