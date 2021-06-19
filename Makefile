PROJ_NAME=temp_proj
PASSWORD=1234
USR_EMAIL='jay.luke.kim@gmail.com'
USR_NAME='JK'

# Targets for project preparation
# Typical order:
#   make build && make run (on the host terminal)
#   make start (on the container side)

folders:
	mkdir -p data/interim
	mkdir -p data/processed
	mkdir -p data/raw
	mkdir models
	mkdir notebooks
	mkdir references
	mkdir -p reports/figures
	mkdir -p src/data
	mkdir -p src/models
	mkdir -p src/visualization

build: Dockerfile
	docker build -t $(PROJ_NAME) .

run:
	docker run -d -e ROOT=TRUE -e PASSWORD=$(PASSWORD) -p 8787:8787 \
		-v $(shell pwd):/home/rstudio \
		--name $(PROJ_NAME) $(PROJ_NAME)

start:
	git config --global user.email $(USR_EMAIL)
	git config --global user.name $(USR_NAME)
	echo '.*\n!/.gitignore\nnotebooks/' > .gitignore
	git init
	git add .
	git commit -m 'initial commit'
	git branch -M main
	make folders

pause:
	docker stop $(PROJ_NAME)

resume:
	docker start $(PROJ_NAME)

renv:
	r -e 'renv::init()'
	r -e 'renv::snapshot()'

clean:
	docker rm -v $(docker ps -a -q)

# Targets for data analysis

data:
	r -e ''

figures:
	r -e ''


