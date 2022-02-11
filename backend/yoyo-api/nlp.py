# Chargement des biblothèques
import re
import spacy

# Charge le petit pipeline français
nlp = spacy.load("fr_core_news_md")


#Fonction de tokenisation
class Model:
    def __init__(self):
        self.intension = None
        self.montant = None

    def cleanToken(self, sentences):
        self.sentences = sentences
        # Tokeniser la phrase en mettant les mots en miniscule
        doc = nlp(sentences.lower())

        # On garde le token s'il ne fait pas partir des stop_words ni des signes
        # de ponctuation et on le lematise
        words = [token.lemma_ for token in doc if token.is_stop is not True and token.is_punct is not True]
        return ' '.join(words)

    def checkKeyWord(self, sentence):
        """
        Fonction qui récupère le mot clé et montant
        :param sentence:
        :type sentence: str
        :return: intension
        :return: montant
        :rtype: str
        """

        key_words = {
            'internet': ["internet", "connexion"],
            'appel': ["appel", "appeler"],
            'sms': ["message", "sms"]
        }
        try:
            self.montant = re.findall('[0-9]+', sentence)[0]  # Récupère le montant
        except:
            pass

        words = sentence.split()  # Variable qui découpe la phrase
        for key, word in key_words.items():
            for mot in word:
                if mot in words:
                    self.intension = key
        return self.intension, self.montant


if __name__ == "__main__":
        # Créé en traitant une chaine de caractères avec l'objet nlp
        internet_sentence = "Je veux forfait de 500"
        sms_sentence = "je veux souscrire à un message de 200"
        cal_sentence = "souscription de pass appel de 300"

        model = Model()
        sentence = model.cleanToken(internet_sentence)
        p, montant = model.checkKeyWord(sentence)

        print(f"intension: {p}, montant:{montant}")
