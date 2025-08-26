#!/bin/bash

make rebuild
echo "* containers building done *\n"
echo -e "\n\n\n"
echo "  I/      wordpress docker logs"
docker logs wordpress_container
echo -e "           * done *\n"
echo -e "\n\n\n"
echo "  II/     mariadb docker logs"
docker logs mariadb_container
echo -e "           * done *\n"
echo -e "\n\n\n"
echo "  III/    nginx docker logs"
docker logs nginx_container
echo -e "           * done *\n"
echo -e "\n\ndocker logs end\n"
