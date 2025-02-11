FROM python:3.9

WORKDIR /

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common

COPY requirements.txt requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

COPY datasets datasets
COPY modules modules
COPY src src
COPY setup.py setup.py
RUN pip3 install .

EXPOSE 8501
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health
ENTRYPOINT ["streamlit", "run", "src/main.py", "--server.port=8501", "--server.address=0.0.0.0"]
