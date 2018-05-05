# Use Python 2.7 Slim
FROM python:2.7-slim

# Update Repos
RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends build-essential sudo git wget curl nmap ruby \
  && apt-get clean

# Install Python dependecies
RUN pip install requests

# Install Aurora
RUN git clone https://github.com/D3F14NC3/AuroraPHP \
  && cd fsociety \
  && chmod +x install.sh \
  && ./install.sh

# Change workdir
WORKDIR /root/.Aurora/

# Hack to keep the container running
CMD python -c "import signal; signal.pause()"
