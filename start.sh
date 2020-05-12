# Creation of .env file
touch .env

# CONTAINER_NAME
  read -p "Enter Container Name: " container_name
  container_name=${container_name:-CodeServer}

# CODESERVER_DATA_PATH
  i=0
  while ((i == 0))
  do
    read -p "Enter Path where your CodeServer files will be located: [/path/to/your/CodeServer]" data_path
    data_path=${data_path:-/path/to/your/CodeServer}
    if [ -z "$data_path" ] || [ $data_path = "/path/to/your/CodeServer" ];
      then
        echo "ERROR DATA PATH, RETRY"
      else
        ((i += 1))
    fi
  done

# DOMAIN(S)
  i=0
  while ((i == 0))
  do
    read -p "Enter Domain name [domain.com]: " domain_name 
    domain_name=${domain_name:-domain.com}
    if [ -z "$domain_name" ] || [ $domain_name = "domain.com" ];
      then
        echo "ERROR DOMAIN NAME, RETRY"
      else
        ((i += 1))
    fi
  done

# LETSENCRYPT_EMAIL
  i=0
  while ((i == 0))
  do
    read -p "Enter Your Mail Address [address@gmail.com]: " mail_address 
    mail_address=${mail_address:-address@gmail.com}
    if [ -z "$mail_address" ] || [ $mail_address = "address@gmail.com" ];
      then
        echo "ERROR MAIL ADDRESS, RETRY"
      else
        ((i += 1))
    fi
  done


# CODESERVER_SSL_PATH
read -p "Path to the certificates [/home/user/webproxy/data/certs]: " cert_path 
cert_path=${cert_path:-/home/user/webproxy/data/certs}

# CODESERVER_CERTIFICATE & CODESERVER_SSL_KEY
Certificate=$cert_path$domain_name

# NETWORK
read -p "Network Name [webproxy]: " vnetwork 
vnetwork=${vnetwork:-address@gmail.com}

#Send Values to .env
  echo "CONTAINER_NAME = $container_name" > .env
  echo "CODESERVER_DATA_PATH = $data_path" > .env
  echo "DOMAINS = $domain_name" >> .env
  echo "MAIN_DOMAIN = $domain_name" >> .env
  echo "LETSENCRYPT_EMAIL = $mail_address" >> .env
  echo "CODESERVER_SSL_PATH = $cert_path" >> .env
  echo "CODESERVER_CERTIFICATE = $Certificate.crt" >> .env
  echo "CODESERVER_SSL_KEY = $Certificate.key" >> .env
  echo "NETWORK = $vnetwork" >> .env

# Final message
  echo 
  echo "#-----------------------------------------------------------"
  echo "# $container_name"
  echo "# ----------------------"
  echo "# Mail : $mail_address"
  echo "# ----------------------"
  echo "# domain(s): $domain_name"
  echo "# ----------------------"
  echo "# Path : $data_path"
  echo "#-----------------------------------------------------------"
  echo

docker-compose up -d

ContainerID=$(docker container ls -l --format "{{.ID}}")
echo $(docker logs $ContainerID)
