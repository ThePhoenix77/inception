#!/bin/bash

make rebuild
echo "* containers building done *\n"
echo -e "\n\n\n"
echo "  I/      wordpress docker logs"
docker logs wordpress
echo -e "           * done *\n"
echo -e "\n\n\n"
echo "  II/     mariadb docker logs"
docker logs mariadb
echo -e "           * done *\n"
echo -e "\n\n\n"
echo "  III/    nginx docker logs"
docker logs nginx
echo -e "           * done *\n"
echo -e "\n\ndocker logs end\n"
