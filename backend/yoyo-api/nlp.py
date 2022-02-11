import re
import spacy

# Charge le moyen pipeline français
nlp = spacy.load("fr_core_news_md")


class Model:
    def __init__(self):
        self.intent = None
        self.amount = None

    def cleanToken(self, sentences: str):
        """
        Applique un pipeline de nettoyage à la phrase
        :param sentence:
        :type sentences: str
        :return: sentence
        :rtype: str
        """
        self.sentences = sentences
        # Instanciation du pipeline sur la phrase préalablement mise en miniscule
        doc = nlp(sentences.lower())

        # On garde le token s'il ne fait pas partir des stop_words ni des signes
        # de ponctuation et on le lematise
        words = [token.lemma_ for token in doc if token.is_stop is not True and token.is_punct is not True]
        return ' '.join(words)

    def checkKeyWord(self, sentence: str):
        """
        Fonction qui extraire le mot clé et montant de la phrase de l'utilisateur
        :param sentence:
        :type sentence: str
        :return: forfait
        :rtype: dict
        """

        key_words = {
            'internet': ["internet", "connexion"],
            'appel': ["appel", "appeler"],
            'sms': ["message", "sms"]
        }
        try:
            # On extrait le premier nombre contenu dans la phrase (il est considéré comme le montant)
            self.amount = re.findall('[0-9]+', sentence)[0]
        except:
            pass

        words = sentence.split()  # Découpe la phrase d'entrée en mots

        # On compare nos mots clés aux mots contenus dans la phrase
        # lorsque nous trouvons une correspondance nous retournons le mot clé
        for key, word in key_words.items():
            for mot in word:
                if mot in words:
                    self.intent = key
        return {
            "name": self.intent,
            "amount": self.amount
        }


if __name__ == "__main__":
    # Créé en traitant une chaine de caractères avec l'objet nlp
    internet_sentence = "Je veux forfait de 500"
    sms_sentence = "je veux souscrire à un message de 200"
    cal_sentence = "souscription de pass appel de 300"

    model = Model()
    sentence = model.cleanToken(sms_sentence)
    forfait = model.checkKeyWord(sentence)

    print(f"intension:{forfait['name']}, montant:{forfait['amount']}")
