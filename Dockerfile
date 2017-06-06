FROM ubuntu:16.04
#FROM continuumio/anaconda3
#FROM kaixhin/lasagne

#############################################################
# Install bleeding-edge Theano and Lasagne, plus all kinds of other stuff
# modified from https://github.com/Kaixhin/dockerfiles/blob/master/theano/Dockerfile
RUN apt-get update && apt-get install -y \
  build-essential \
  gfortran \
  git \
  wget \
  liblapack-dev \
  libopenblas-dev \
  python-dev \
  python-pip \
  python-nose \
  python-numpy \
  python-scipy \
        lsb-release \
        pkg-config \
        build-essential \
        libavcodec-dev \
        libavformat-dev \
        libavutil-dev \
        libavresample-dev \
        fftw3-dev \
        libfreetype6-dev \
        wget \
        git \
        curl \
        vim \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-ugly \
        libav-tools \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --upgrade six
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git
RUN pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip

#################################################

RUN lsb_release -a

# TensorFlow
#ENV TENSORFLOW_VERSION 1.0.0
#RUN pip install tensorflow==$TENSORFLOW_VERSION 

# ffmpeg and LibRosa
#RUN conda install -c conda-forge ffmpeg librosa
COPY requirements.txt /
RUN pip install -r requirements.txt
#RUN pip install --upgrade ipython jupyter

COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly:
# https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# tensorboard
#EXPOSE 6006

# jupyter
EXPOSE 8888
EXPOSE 8889

# X11
ENV DISPLAY :0

WORKDIR "/notebooks"

CMD ["sh", "/run_jupyter.sh", "spectrogram_autocorrelations"]
