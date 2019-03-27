**Bonjour tous le monde, j'ai récemment programmer pour un server en node js pour faire du MySql.** 

------------------

*Avant de commencer je vais vous expliquer quelque base important.*
<br/>

**Le MySQL :**

**MySQL**  est un serveur de bases de données relationnelles Open Source. Un serveur de bases de données stocke les données dans des tables séparées plutôt que de tout rassembler dans une seule table. ... Le SQL dans " **MySQL** " signifie "Structured Query Language" : le langage standard pour les traitements de bases de données. 

*Voici un exemple avec un schéma.*

![Shema|570x267,80%](upload://bjXG3ilug2uNlzAotBLT2MnEmCe.png) 
Pour que vous compreniez mieux, le client ( donc un jeu roblox ou autre ) envoi un requête à votre serveur. Le script en node js vas ensuite lire la demande et va stocker, modifier une valeur dans la database. Puis le script en node js vah par la suite envoyer les informations qui ont été demandé par le client.

**Node JS :**

Node js est un language de programation en *open-source*.

**Les module utilisés dans le *Server.js* :**
[details="mysql"]
*Le module principale pour interagir avec votre base de donnée.* 
Instalation : **npm install mysql**
[/details]

[details="express"]
*Express est un framework pour construire des applications web basées sur Node Js.*
Instalation : **npm install express**
[/details]

[details="body-parser"]
*body-parser parse le body d'une requête.* 
Instalation : **npm install body-parser**
[/details]
<br/>

**Mise en place du module dans votre jeu :**

Pour commencer, vous aller devoir vous rendre sur mon [**github**](https://github.com/RobxSoft/Roblox-MySql-Server)
Vous aller prendre par la suite le fichier qui se nomme **DB.lua** puis l'insérer sur roblox en tant que ModuleScript. Voici ce que vous devriez voir pour le moment :

![Screenshot_2|259x65](upload://8WqDHOB3SLgEG9ofKQ87z8FeCZf.png) 

**Mise en place du Server.js dans votre VPS ( virtual private server) :**
Un VPS est payant mais il existe des solutions alternatives gratuite comme [**glitch**](https://glitch.com/) ou autre.
Je n'ai personnellement pas essayé sur glitch mais si besoin je peut aussi vous aider a la mise en place du *Server.js* sur glitch.

Donc pour commencer si vous n'avez pas Node js d'installer sur votre VPS, faites les commands suivantes : 

[details="Pour linux Ubuntu / Debian "]
```
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install npm
```
[/details]
[details="Pour windows"]
Personnellement je ne trouve pas de ligne de commande pour Windows. Merci de me dire si vous en trouver.
Sinon prenez l’installation manuelle : [**nodejs**](https://nodejs.org/fr/)  
[/details]
Maintenant, rendez-vous sur mon [**github**](https://github.com/RobxSoft/Roblox-MySql-Server) et prenez le fichier **Server.js** .
Si dans la racine de votre VPS, vous avez un dossier nommer *ipvsp*, c'est bon. Sinon ajouter le.

 [details="Racine du VPS"]
![Screenshot_1|252x488,75%](upload://319JUJHAXW1B0bdR9TLFq4QDhQp.png) 
[/details]

Par la suite, ajouter le fichier *Server.js* dans le le dossier *ipvps*.
Personnellement j'utilise un plugin que se nomme *pm2* qui me permet d'avoir les logs du fichier *Server.js*, de le mettre en pause, de le redémarrer, ect...
 [details="Pour l’installer"]
```
npm install pm2
```
[/details]

Nous allons maintenant rentrer les informations requises pour la connection à notre Database.
Rendez-vous donc sur la page de phpmyadmin de votre VPS. (*Pour plus d'information comment installer phpmyadmin rendez vous sur [phpmyadmin](https://docs.phpmyadmin.net/fr/latest/setup.html)*).
Si vous n'avez jamais modifier le mot de passe root alors, entrer dans Utilisateur : Root et rien dans Mot de passe.
 [details="Page d’accueil de phpmyadmin"]
![Screenshot_5|509x499](upload://92ImZjRcSwqG85R7JcYDN7IuqsG.png)  
[/details]
Maintenant, nous allons crée un nouvelle base de données. Pour ceci cliquer sur le boutton *Nouvelle base de données*
![Screenshot_6|292x182,60%](upload://3NdJ58XtkwJCRPXsgNeOCTqoILz.png) 
Vous arriverez par la suite sur une page comme celle-ci : 

![Screenshot_7|690x153,50%](upload://skAGFthkxfp3PswjUdzNrzdW4MR.png) 
Ajouter donc le nom de la base do données puis cliquer sur *Créer*. Par la suite nous arriverons sur une page comme celle-ci : 
![Screenshot_8|690x111,75%](upload://fTc28bmo4YokCBJ2Lirs3UymBKs.png)  
Dans le *Nom*, nous rentrons **users** puis nous cliquons sur *Exécuter*. Nous arrivons donc sur cette page :

![Screenshot_9|690x270,75%](upload://qIUliP6LGzEzAop405QQZgZwNe6.png) 

Maintenant vous pouvez choisir les noms des colonnes que vous voulez. N'oubliez pas de mettre la *Valeur par défaut* en *NULL*.

[details="Exemple"]
![Screenshot_10|690x257,75%](upload://Upsab0LuW7iKCRMBVGyZ61uE2P.png) 
[/details]

Puis quand vous avez fini, appuyez sur *Sauvgarder*.

Maintenant revenez dans le fichier *Server.js* pour modifier les paramètres situer ici : 

![Screenshot_11|690x159](upload://eQJgib9xcwx3vs0jQSu1kbCzHtt.png) 

Si vous êtes sur VPS, dans *host* entré l'Ip de votre VPS. Sinon chercher l'host de ou vous avez mis le *Server.js*.
Pour *user* et *password* vous aller mettre ce que vous avez rentrer au début lors de votre connexion à phpmyadmin. 
Pour *database*, vous rentrer le nom de la databae que vous avez crée précedement.

Pour finir, définir un mot de passe dans le *Server.js* dans la variable se trouvant à la première ligne : 
```js
const pass = 'mot de passe ici'
```
Puis sauvgarder.

**Lancement du fichier Server.js :**
Si vous venez d'installer *pm2*, faites les commandes suivantes : 
```
cd /ipvps/
pm2 start Server.js
```
Sinon faites les commandes suivantes : 
```
cd /ipvps/
node Server.js
```
**Paramètre du module :**
Dans le module *DB.js*, vous pouvez trouver 2 paramètres que vous devez absolument indiquer.

![Screenshot_3|690x68](upload://z91eigsAXAaE3aZ4LUydRMDayli.png) 

*Url* : ceci est le host ou votre fichier *Server.js* est mis. Si vous êtes sur VPS le host devrait être : ``http://ip:8081``
Exemple : 
``http://01.252.252.25:8081``

*PASS* : indiquer ici le mot de passe que vous avez entrez précédemment dans le fichier *Server.js* 

**Comment utilisé le module**:
Dans un script située dans *ServerScriptService*, déplacer le module dans le script : 
![Screenshot_4|269x81,50%](upload://ykzlLrZyu0ftUdScdNCHPRh8nBt.png) 

Pour commencer n'oublier pas de require le module au début du script : 
```
local db = require(script.DB)
``` 
<br/>

- Recevoir les données d'un utilisateur : 
```
db:get(username, id, function(Success, Value, ServerResponse)
		
end)
```
[details="Exemple"]
```
db:get("RobxSoft", 627510840, function(Success, Value, ServerResponse)
		
end)
```
[/details]
<br/>

- Ajouter / Soustraire une / des valeurs à un joueur : 

```
local tabl = {
	["Coins"] = -50,
	["Kills"] = 1,
}

db:post(username, id, tabl, function(Success, Value, ServerResponse)

end)
```

[details="Exemple"]
```
local tabl = {
	["Coins"] = -50,
	["Kills"] = 1,
}

db:post("RobxSoft", 627510840, tabl, function(Success, Value, ServerResponse)

end)
```
[/details]
<br/>

- Modifier une valeur d'un joueur : 

```
local tabl = {
	["Coins"] = 50,
	["Kills"] = 0,
}

db:change(id, tabl, function(Success, Value, ServerResponse)
	
end)
```

[details="Exemple"]
```
local tabl = {
	["Coins"] = 50,
	["Kills"] = 0,
}

db:change(627510840, tabl, function(Success, Value, ServerResponse)

end)
```
[/details]
<br/>

- Supprimer les infos d'un joueur : 

```
db:delete(id, function(Success, Value, ServerResponse)

end)
```

[details="Exemple"]
```
db:delete(627510840, function(Success, Value, ServerResponse)

end)
```
[/details]
<br/>

**Exemple de script permettant de connaitre les infos d'un user :**

```
game.Players.PlayerAdded:Connect(function(plr)
	db:get(plr.Name, plr.UserId, function(Success, Value, ServerResponse)
		if Success then
			if Value then
				for key, value in pairs(Value) do
					print(key, value)
				end
			end
		end
	end)
end)
```

**Autres commandes utiles de pm2 :**

``pm2 ls ``(Affiche chaque script 'allumé' par pm2)

``pm2 restart 0`` ( Va redémarrer le script choisi ( remplacer 0 par l'id du script que vous voulez remplacer))

``pm2 log 0`` (Va afficher les logs du script choisi ( remplacer 0 par l'id du script que vous voulez remplacer))

``pm2 delete 0`` (Va stopper et supprimer de la liste le script choisi( remplacer 0 par l'id du script que vous voulez remplacer))

**Remercient :**

@Gagou_Bloxxer : Aide pour fix quelque problème.
@RSAiste : Aide pour fix quelque problème.

**Si vous avez des questions, n'hésiter pas! Si vous avez des retours sur le module, n'hésiter pas!**

Merci
