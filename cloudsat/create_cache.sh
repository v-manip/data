#!/bin/sh -e


# Create gltf folder, which is then exported via httpd
mkdir -p /var/www/cache/gltf
chown apache.apache /var/www/cache/gltf

# Create Cloudsat sqlite.db
cat << EOF > /tmp/bootstrap_cloudsat.txt
create table if not exists tiles(
                        tileset text,
                        grid text,
                        x integer,
                        y integer,
                        z integer,
                        data text,
                        dim text,
                        ctime datetime,
                        primary key(tileset,grid,x,y,z,dim)
                    );

EOF
sqlite3 /var/www/cache/Cloudsat.sqlite < /tmp/bootstrap_cloudsat.txt
chown apache.apache /var/www/cache/Cloudsat.sqlite
rm /tmp/bootstrap_cloudsat.txt
