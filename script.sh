rm -rf out 
mkdir out
# CREATING KEY
openssl genrsa \
-out out/key1.pem 4096

# CREATING CSR
openssl req -new -key out/key1.pem \
-out out/csr1.pem \
-config ssl.cnf


# CHECK SAN IN CSR
openssl req -in out/csr1.pem -noout -text | grep -A 1 "Subject Alternative Name"

# CREATE CERT
openssl x509 -req -days 36500 -in out/csr1.pem \
-signkey out/key1.pem \
-out out/cert1.pem \
-extensions req_ext -extfile ssl.cnf

# DISPLAY CERTIFICATE CONTENT
openssl x509 -in out/cert1.pem -noout -text