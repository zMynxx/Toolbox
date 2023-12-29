from fastapi import FastAPI
app = FastAPI()

import debugpy

debugpy.listen(("0.0.0.0", 5678))
print("Waiting for client to attach...")
debugpy.wait_for_client()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/hits")
def read_root():
    return {"Number of hits:": "4"}