import uvicorn
from fastapi import FastAPI
from pydantic import BaseModel
import json
import nlp

with open('synthaxe.json') as synthaxe:
    data = json.load(synthaxe)


def checkSyntax(service: str, amount: str):
    """

    :param service:
    :type service: str
    :param amount:
    :type amount: str
    :return:
    :rtype:
    """
    syntaxe = None
    for key in data.keys():
        if service.lower() == key.lower():
            syntaxe = data[key].get(amount)  # Renvoir None sinon
            break
    return syntaxe


class SentenceModel(BaseModel):
    texts: str


app = FastAPI(title="YOYO-API")


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}


@app.post("/yoyo/")
async def yoyo(sentence: SentenceModel):
    # ?service=sms&montant=150
    model = nlp.Model()
    clean_sentence = model.cleanToken(sentence.texts)
    forfait = model.checkKeyWord(clean_sentence)
    syntaxe = checkSyntax(service=forfait["name"], amount=forfait["amount"])

    return {"syntaxe": syntaxe}


if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=800)
