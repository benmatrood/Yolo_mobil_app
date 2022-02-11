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


app = FastAPI(title="YOYO-API")


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/yoyo/")
async def yoyo(sentence: str):
    # ?service=sms&montant=150
    model = nlp.Model()
    clean_sentence = model.cleanToken(sentence)
    forfait = model.checkKeyWord(clean_sentence)
    try:
        syntaxe = checkSyntax(service=forfait["name"], amount=forfait["amount"])
    except:
        syntaxe = None
    return {"syntaxe": syntaxe}


# if __name__ == "__main__":
#     uvicorn.run(app, host="127.0.0.1", port=800)
