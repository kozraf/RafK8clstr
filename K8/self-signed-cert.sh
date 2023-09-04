sudo openssl genrsa -out selfsignedcert.key 2048
#sudo openssl req -new -key selfsignedcert.key -out selfsignedcert.csr
openssl req -new -key selfsignedcert.key -out selfsignedcert.csr \
    -subj "/C=UK/CN=node1.local"
sudo openssl x509 -req -days 365 -in selfsignedcert.csr -signkey selfsignedcert.key -out selfsignedcert.crt
