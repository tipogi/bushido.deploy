FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9

# The folder that we will copy all the project
WORKDIR /app

COPY bushido.market/etc/fastapi/requirements.txt /app/requirements.txt

# Install the pip and project dependencies packages
RUN /usr/local/bin/python -m pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

## Docker health check
HEALTHCHECK --interval=300s --timeout=15s --start-period=60s --retries=3 \
            CMD curl http://nokyc-api:8081/docker-healthcheck

# That variable will be find in the run.sh
# run.sh is a clone of start-reload.sh which is located by default in the root path
ENV PORT=8081

CMD ["uvicorn", "app.main:app"]