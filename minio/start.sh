#curl -sSL --tlsv1.2 \
#     -O 'https://raw.githubusercontent.com/minio/kes/master/root.key' \
#     -O 'https://raw.githubusercontent.com/minio/kes/master/root.cert'
export MINIO_KMS_KES_ENDPOINT=https://play.min.io:7373
export MINIO_KMS_KES_KEY_FILE=root.key
export MINIO_KMS_KES_CERT_FILE=root.cert
export MINIO_KMS_KES_KEY_NAME=my-minio-key
export MINIO_ROOT_USER=minioadmin
export MINIO_ROOT_PASSWORD=minioadmin
minio server /opt/s3
