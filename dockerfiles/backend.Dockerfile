FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
USER 1001
EXPOSE 5000
HEALTHCHECK CMD curl -f http://localhost:5000/health || exit 1
CMD ["python","app.py"]
