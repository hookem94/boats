
#
# This Docker image encapsulates the malwoverview tool

FROM python:latest
ENV DEBIAN_FRONTEND noninteractive
COPY .malwapi.conf /root/.malwapi.conf
RUN pip install -Iv requests==2.22.0
RUN python -m pip install -U malwoverview
