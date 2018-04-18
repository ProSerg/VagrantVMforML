# Variables
NotebooksDir="/notebooks/"
# size of swapfile in megabytes
swapsize=8000

echo ">>> Provisioning virtual machine..."
apt-get update

# Git
# does the git file already exist?
command -v git 
if [ $? -ne 0 ]; then
    echo ">>> Installing Git"
    apt-get install -y git 
fi

# does the Docker file already exist?
command -v docker
if [ $? -ne 0 ]; then
    # Docker
    echo ">>> Installing Docker" 
    apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    apt-key fingerprint 0EBFCD88
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

    apt-get update
    apt-get install -y docker-ce
    apt-cache madison docker-ce
fi

# does the python3.6 file already exist?
command -v python3.6
if [ $? -ne 0 ]; then
    # Python 3
    echo ">>> Installing Python 3.6"
    add-apt-repository ppa:deadsnakes/ppa
    apt-get update
    apt-get install -y python3.6
    curl https://bootstrap.pypa.io/get-pip.py | python3.6
    apt-get install python3.6-venv
    pip3.6 install -U pip 

    update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1
    update-alternatives --install /usr/bin/python python /usr/bin/python3.6 10
fi 

echo ">>> Installing ML libraries"

# does the requirements already update?
pip install -U pandas 
pip install -U graphviz
pip install -U requests
pip install -U bs4
pip install -U pymorphy2
pip install -U gensim
pip install -U numpy
pip install -U matplotlib
pip install -U sklearn
pip install -U hyperopt
pip install -U seaborn
pip install -U scipy
pip install -U networkx==1.11

# does the jupyter file already exist?
command -v jupyter 
if [ $? -ne 0 ]; then
    echo ">>> Installing Jupyter"
    python -m pip install jupyter
    jupyter notebook --generate-config -y

    cp -r /data/jupyter.service /etc/systemd/system

    mkdir -p /home/vagrant/.jupyter/
    cp -r /data/jupyter_notebook_config.py /home/vagrant/.jupyter/
fi

echo ">>> Demonization Jupyter"

systemctl enable jupyter.service
systemctl daemon-reload
systemctl restart jupyter.service
systemctl status jupyter
jupyter notebook list

echo "Jupyter == http://localhost:8080/?token=sha1:cf2a799f39bc:aad334f602bf3425668db12f7170e8048eac99d6"
# ifconfig -a | grep 'inet ' | grep -v '0.1'  | awk '{print $2}' | cut -f1 -d'/'

echo ">>> Finished setuping."


# does the swap file already exist?
grep -q "swapfile" /etc/fstab

# if not then create it
if [ $? -ne 0 ]; then
  echo '>>> swapfile not found. Adding swapfile.'
  fallocate -l ${swapsize}M /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
  echo 'swapfile found. No changes made.'
fi

# output results to terminal
df -h
cat /proc/swaps
cat /proc/meminfo | grep Swap