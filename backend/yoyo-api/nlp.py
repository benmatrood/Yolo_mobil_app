# Chargement des biblothèques
import re
import spacy

# Charge le petit pipeline français
nlp = spacy.load("fr_core_news_md")


#
def cleanToken(sentences):
    # Tokeniser la phrase en mettant les mots en miniscule
    doc = nlp(sentences.lower())

    # On garde le token s'il ne fait pas partir des stop_words
    words = [token.lemma_ for token in doc if token.is_stop is not True and token.is_punct is not True]
    return ' '.join(words)


# Fonction de selection de mot clé
def check_key_word(sentence):
    """
    :param sentence:
    :type sentence: str
    :return: intension
    :return: montant
    :rtype: str
    """
    intension = None
    montant = None
    key_words = {
        'internet': ["internet", "connexion"],
        'appel': ["appel", "appeler"],
        'sms': ["message", "sms"]
    }
    try:
        montant = re.findall('[0-9]+', sentence)[0]  # Récupère le montant
    except:
        pass

    words = sentence.split()  # Variable qui découpe la phrase
    for key, word in key_words.items():
        print(f"key:{key} word:{word}")
        if type(word) is list:
            for mot in word:
                if mot in words:
                    intension = key
        else:
            if word in words:
                intension = key
    return intension, montant


# Créé en traitant une chaine de caractères avec l'objet nlp
internet_sentence = "Je veux forfait de 500"
sms_sentence = "je veux souscrire à un message de 200"
cal_sentence = "souscription de pass appel de 300"

sentence = cleanToken(cal_sentence)  # Traitement de la
print(sentence)
p, montant = check_key_word(sentence)
print(f"intension: {p}, montant:{montant}")
