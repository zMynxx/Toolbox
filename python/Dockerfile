FROM python:3.10-slim

# set the working directory
WORKDIR /app

# install dependencies
ADD app/requirements.txt .
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# copy the src to the folder
ADD app/src .

# start the server
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80", "--reload"]