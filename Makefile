# ===== Interface ===== #
BLACK			:= $(shell tput -Txterm setab 0 && tput -Txterm setaf 7)
RED				:= $(shell tput -Txterm setab 1 && tput -Txterm setaf 0)
GREEN			:= $(shell tput -Txterm setab 2 && tput -Txterm setaf 0)
YELLOW		:= $(shell tput -Txterm setab 3 && tput -Txterm setaf 0)
BLUE			:= $(shell tput -Txterm setab 4 && tput -Txterm setaf 0)
MAGENTA 	:= $(shell tput -Txterm setab 5 && tput -Txterm setaf 0)
CYAN			:= $(shell tput -Txterm setab 6 && tput -Txterm setaf 0)
WHITE			:= $(shell tput -Txterm setab 7 && tput -Txterm setaf 0)
RESET			:= $(shell tput -Txterm sgr0)
BLACK_TEXT	:= $(shell tput -Txterm setaf 0)
RED_TEXT		:= $(shell tput -Txterm setaf 1)
GREEN_TEXT	:= $(shell tput -Txterm setaf 2)
YELLOW_TEXT	:= $(shell tput -Txterm setaf 3)
BLUE_TEXT		:= $(shell tput -Txterm setaf 4)
MAGENTA_TEXT 	:= $(shell tput -Txterm setaf 5)
CYAN_TEXT		:= $(shell tput -Txterm setaf 6)
WHITE_TEXT	:= $(shell tput -Txterm setaf 7)

# ===== Global Vars ===== #
SERVICE_DIR				:=$(notdir $(shell pwd))
SERVICE_PATH			:=$(shell pwd)
CONTAINER_USER		:=dockeruser
CONTAINER_NAME		:=$(SERVICE_DIR)

# ===== Make Commands ===== #
all: clean build run exec
dev: clean build run exec

debug:
	@echo "${CYAN} $@ ${RESET} ${CYAN_TEXT} Displaying vars for debugging ... ${RESET}"
	@echo SERVICE_DIR: $(SERVICE_DIR)
	@echo SERVICE_PATH: $(SERVICE_PATH)
	@echo CONTAINER_USER: $(CONTAINER_USER)
	@echo CONTAINER_NAME: $(CONTAINER_NAME)

clean:
	@echo "${CYAN} $@ ${RESET} ${CYAN_TEXT} removing $(CONTAINER_NAME) container... ${RESET}"
	@docker container rm -f $(CONTAINER_NAME)

clean-force:
	@echo "${CYAN} $@ ${RESET} ${CYAN_TEXT} removing $(CONTAINER_NAME) containers and images... ${RESET}"
	@docker container rm -f $(CONTAINER_NAME)
	@docker image rm -f $(CONTAINER_NAME)

build:
	@echo "${CYAN} $@ ${RESET} ${CYAN_TEXT} building the $(CONTAINER_NAME) container... ${RESET}"
	@docker build \
	  -t $(CONTAINER_NAME) \
	  --build-arg USERNAME=$(CONTAINER_USER) \
	  .

run: clean
	@echo "${CYAN} $@ ${RESET} ${CYAN_TEXT} running the $(CONTAINER_NAME) container... ${RESET}"
	@docker run -d \
      -h $(CONTAINER_NAME) \
      --name $(CONTAINER_NAME) \
      --rm \
      -v $(SERVICE_PATH)/src:/app/src \
			-v $(SERVICE_PATH)/tests:/app/tests \
      $(CONTAINER_NAME)

test: clean
	@echo "${CYAN} $@ ${RESET} ${CYAN_TEXT} running unittest testing suite... ${RESET}"
	@docker run -i \
      -h $(CONTAINER_NAME) \
      --name $(CONTAINER_NAME) \
      -v $(SERVICE_PATH)/src:/app/src \
			-v $(SERVICE_PATH)/tests:/app/test \
			--entrypoint python \
			$(CONTAINER_NAME) \
			-m unittest

release:
	@echo "${CYAN} $@ ${RESET} ${CYAN_TEXT} running the $(CONTAINER_NAME) container... ${RESET}"
	docker run -d \
      -h $(CONTAINER_NAME) \
      --name $(CONTAINER_NAME) \
      --rm \
      $(CONTAINER_NAME)

exec:
	@echo "${CYAN} $@ ${RESET} ${CYAN_TEXT} executing into the $(CONTAINER_NAME) container... ${RESET}"
	@docker exec -it $(CONTAINER_NAME) bash
