# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tboussad <tboussad@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/05 14:25:12 by tboussad          #+#    #+#              #
#    Updated: 2025/09/28 12:14:31 by tboussad         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: build up

build:
	docker compose -f srcs/docker-compose.yml build

up:
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

# clean: down
#     docker system prune -a

# fclean: clean
#     - docker volume rm wordpress mariadb
#     - sudo rm -rf /home/tboussad/data/*
#     - mkdir -p /home/tboussad/data/wordpress /home/tboussad/data/mariadb

# re: fclean all

rebuild: down build up