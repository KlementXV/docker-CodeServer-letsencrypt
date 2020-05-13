# Creation of .env file
clear
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

# PASSWORD_VS
  i=0
  while ((i == 0))
  do
    read -p "Enter Your Password For VS: " Password 
    if [ -z "$Password" ];
      then
        echo "ERROR PASSWORD IS NULL, RETRY"
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
vnetwork=${vnetwork:-webproxy}

#Send Values to .env
  echo "CONTAINER_NAME=$container_name" >> .env
  echo "CODESERVER_DATA_PATH=$data_path" >> .env
  echo "DOMAINS=$domain_name" >> .env
  echo "MAIN_DOMAIN=$domain_name" >> .env
  echo "LETSENCRYPT_EMAIL=$mail_address" >> .env
  echo "CODESERVER_SSL_PATH=$cert_path" >> .env
  echo "CODESERVER_SSL_CERTIFICATE=$Certificate.crt" >> .env
  echo "CODESERVER_SSL_KEY=$Certificate.key" >> .env
  echo "ADMIN_PASSWORD=$Password" >> .env
  echo "NETWORK=$vnetwork" >> .env

# Final message
  echo 
  echo "#-----------------------------------------------------------"
  echo "# Name : $container_name"
  echo "# ----------------------"
  echo "# Domain : $domain_name"
  echo "# ----------------------"
  echo "# Password : $Password"
  echo "# ----------------------"
  echo "# Path : $data_path"
  echo "#-----------------------------------------------------------"
  echo

echo "DOCKER COMPOSE UP"
docker-compose up -d

sleep 10

rm -rf .env