from flask import Flask, request, json, jsonify
from pydantic import BaseModel
import nlp

app = Flask(__name__)


@app.route('/yoyo', methods=['POST'])
def checkSyntax(service: str, amount: str):
    with open('synthaxe.json') as synthaxe:
        data = json.load(synthaxe)

    syntaxe = None
    for key in data.keys():
        if service.lower() == key.lower():
            syntaxe = data[key].get(amount)  # Renvoir None sinon
            break
    return syntaxe


def yoyo():
    # query = request.form['query']
    query = "Souscription 150"
    # ?service=sms&montant=150
    model = nlp.Model()
    clean_sentence = model.cleanToken(query)
    forfait = model.checkKeyWord(clean_sentence)
    syntaxe = checkSyntax(service=forfait["name"], amount=forfait["amount"])

    return jsonify({"reponse": syntaxe})


if __name__ == '__main__':
    app.run(debug=True)