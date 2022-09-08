set -e
yum install -y gcc
curl -O https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
tar xzf Python-3.6.1.tgz
cd Python-3.6.1
ls
./configure
yum install -y openssl-devel
make install
cd ..
rm -rf Python-3.6.1*
ls
python3.6 -V

pip3 install -U pip
