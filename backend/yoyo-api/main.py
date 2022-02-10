import uvicorn
from fastapi import FastAPI
import json

with open('synthaxe.json') as synthaxe:
    data = json.load(synthaxe)

app = FastAPI(title="YOYO-API")


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}


@app.get("/yoyo/")
async def yoyo(service: str, montant: str):
    # ?service=sms&montant=150
    syntaxe = None
    for key in data.keys():
        if service.lower() == key.lower():
            syntaxe = data[key].get(montant)  # Renvoir None sinon
            break
    return {"syntaxe":  syntaxe}

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=800)
