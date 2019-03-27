const pass = '' //Ajouter un mot de passe ici ( il doit étre le même que celui que vous avez entré dans le module )

const mysql = require('mysql')

var express = require('express');
var app = express();
var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({
  extended: true
}));


//DB

var connection = mysql.createConnection({
  socketPath : '/var/run/mysqld/mysqld.sock',
  host : '', //Mettre le host ici ( EXEMPLE : "01.252.252.25)".
  user : '', //Mettre le user de votre base de donnée ici
  password : '', //Mettre le mot de passe de votre base de donné ici
  database: '' //Mettre le nom de la database sur laquel votre jeu stock les informations.
});

connection.connect(function(err) {
  console.log("Connexion à la base de donnée...")
  if (err) {
    console.log("La connexion a échoué :\n\n" + err + "\n")
    return
  }
  console.log("Connecté à la base de donnée")

  function create(userid, username, res){
    var sql = `INSERT INTO users(Roblox_ID, Roblox_Username) VALUES ("${userid}", "${username}")`
    connection.query(sql, (err, result) => {
      if (err) return console.error(err)
      res.status(200);
      res.send(
        result[0]
      );
    })
  }

  function passF(pass2){
    if(pass2 === pass){
      return true;
    }else {
      return false;
    }
  }

  app.post("/getDB", function(req, res) {
    if (passF(req.headers["pass"]) === false){
      res.status(403);
      res.send({message: "Pass doens't match."});
      return;
    }
    connection.query(`SELECT * FROM users WHERE Roblox_ID = ${req.headers["userid"]}`, function (err, result) {
      if (err) throw err;
      if(!result.length){
        create(req.headers["userid"], req.headers["username"], res)
      }else{
        res.status(200);
        res.send(
          result[0]
        );
      }
    });
  })

  app.post("/postDB", function(req, res) {
    if (passF(req.headers["pass"]) === false){
      res.status(403);
      res.send({message: "Pass doens't match."});
      return;
    }
    connection.query(`SELECT * FROM users WHERE Roblox_ID = ${req.headers["userid"]}`, function (err, result1) {
      if (err) throw err;
      if(req.body){
        for (var key in req.body) {
          let obj = JSON.parse(key)
          for(var key2 in obj){
            connection.query(`UPDATE users SET ${key2} = +${result1[0][key2]} + ${obj[key2]} WHERE Roblox_ID = ${req.headers["userid"]}`, function(err, result){
              if(err){
                res.status(403);
                res.send({
                  err
                });
              }else {
                if(result){
                  res.status(200);
                  res.send(
                    result1[0]
                  );
                }
              }
            })
          }
        }
      }
    });
  })

  app.post("/changeDB", function(req, res) {
    if (passF(req.headers["pass"]) === false){
      res.status(403);
      res.send({message: "Pass doens't match."});
      return;
    }
    connection.query(`SELECT * FROM users WHERE Roblox_ID = ${req.headers["userid"]}`, function (err, result1) {
      if (err) throw err;
      if(req.body){
        for (var key in req.body) {
          let obj = JSON.parse(key)
          for(var key2 in obj){
            connection.query(`UPDATE users SET ${key2} = ${obj[key2]} WHERE Roblox_ID = ${req.headers["userid"]}`, function(err, result){
              if(err){
                res.status(403);
                res.send({
                  err
                });
              }else {
                if(result){
                  res.status(200);
                  res.send(
                    result1[0]
                  );
                }
              }
            })
          }
        }
      }
    });
  })

  app.post("/deleteDB", function(req, res) {
    if (passF(req.headers["pass"]) === false){
      res.status(403);
      res.send({message: "Pass doens't match."});
      return;
    }
    connection.query(`DELETE FROM users WHERE Roblox_ID = ${req.headers["userid"]}`, function (err, result1) {
      if (err) throw err;
      res.status(200);
      res.send(
        result1[0]
      );
    })
  })

})

var list = app.listen(8081, function() {
  console.log('Server Online, Port ' + list.address().port);
});
