#!/bin/bash

make rebuild
echo "* containers building done *\n"
echo -e "\n\n\n"
echo "Containers logs:\n"
echo "         *wordpress: "
docker logs wordpress
echo -e "***************************************************\n"
echo -e "\n\n\n"
echo "         *mariadb: "
docker logs mariadb
echo -e "***************************************************\n"
echo -e "\n\n\n"
echo "       *nginx: "
docker logs nginx
echo -e "***************************************************\n"
echo -e "\n\n\n"
echo "       *redis: "
docker logs redis
echo -e "***************************************************\n"
echo -e "\n\n\n"
echo "       *adminer: "
docker logs adminer
echo -e "***************************************************\n"
echo -e "\n\n\n"
echo "       *portainer: "
docker logs portainer
echo -e "***************************************************\n"
echo -e "\n\ndocker logs end\n"
