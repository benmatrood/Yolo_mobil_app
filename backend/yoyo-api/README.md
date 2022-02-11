# Yolo_mobil_app
Chat boot et application de commande vocal

1. Api ramenant les différentes syntaxes 

    ##### Que fait l'API ?
    La fonction yoyo de l'Api prends le montant et le service et retourne la syntaxe de souscription.
    
    #### Installation
     - Installer python 3.8 ( https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe) et ajouter python au PATH;
     - Créer un environnement virtuel avec ***py -3.8 -m venv venv***
     - Installer le requirements.txt avec ***pip install -r requirements.txt***
     - Si le fr-core-news-md ne s'installe pas, faire ***python -m spacy download fr-core-news-md***
     
2. Modèle de traitement de la phrase

    ##### Que fait le modèle ? :
     - Tokenise la phrase en la mettant en minuscule; 
     - Nettoie la phrase en enlevant les ponctuations puis les mots inutiles tels que: Je, tu,.. 
     - Découpe le reste de la phrase en mots; 
     - Compare la liste de mots avec la liste de mots-clés prédéfinie 
     - Récupère l'intention s'il y a, sinon il ramène "None"; 
     - Récupère le montant s'il y a, sinon "None";

    #### Installation
     - Installer le requirements.txt avec ***pip install -r requirements.txt***
     - Exécuter le code ***nlp.py***





