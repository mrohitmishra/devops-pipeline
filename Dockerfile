FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
WORKDIR /app

# copy app folder and requirements
COPY app/ ./app/
COPY app/requirements.txt ./app/requirements.txt

RUN pip install --upgrade pip \
    && pip install -r ./app/requirements.txt

EXPOSE 5000

# run gunicorn serving the WSGI app object at app:app
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]