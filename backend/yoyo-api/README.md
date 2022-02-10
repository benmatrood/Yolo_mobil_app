# Yolo_mobil_app
Chat boot et application de commande vocal

1. Api ramenant les différentes syntaxes 

    ##### Que fait l'API ?
    La fonction yoyo de l'Api prends le montant et le service et retourne la syntaxe de souscription.
    
    #### Installation
     - Créer un environnement virtuel avec python 3.8;
     - Installer le requirements.txt avec ***pip install -r requirements.txt***
     
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
     - Exécuter le code ***model.py***





