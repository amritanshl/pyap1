FROM python:3.13.9-slim

WORKDIR /app

COPY requirement.txt .
RUN pip install --no-cache-dir -r requirement.txt

COPY app.py . 
COPY templates/ ./templates

RUN mkdir /data

EXPOSE 5002

CMD [ "python", "app.py" ]