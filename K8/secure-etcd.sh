#https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/

#To check if it is already configured
#ps -aux | grep kube-api | grep "encryption-provicer-confg"
#OR
#sudo cat /etc/kubernetes/manifests/kube-apiserver.yaml

# Assign the output of the command to a variable
KEY=$(head -c 32 /dev/urandom | base64)

# Generate etcs-encryption.yaml
sudo tee /home/vagrant/K8/etcd-encryption.yaml <<EOF
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
      - configmaps
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: <BASE 64 ENCODED SECRET>
      - identity: {}
EOF

# Replace <BASE 64 ENCODED SECRET> in the etcs-encryption.yaml file with the variable value
sudo sed -i "s|<BASE 64 ENCODED SECRET>|${KEY}|" /home/vagrant/K8/etcd-encryption.yaml

sudo sed -i '/- --etcd-keyfile=\/etc\/kubernetes\/pki\/apiserver-etcd-client.key/a\ \n  - --encryption-provider-config=\/home\/vagrant\/K8\/etcd-encryption.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml



sudo apt update
sudo apt install etcd-client

etcdctl --write-out=table --endpoints=<ETCD_ENDPOINTS> \
  --user=<USERNAME>:<PASSWORD> \
  --cert=<CERT_FILE> --key=<KEY_FILE> --cacert=<CA_CERT_FILE> \
  mk /<PREFIX>/config/encryption_key <32_BYTE_ENCRYPTION_KEY>