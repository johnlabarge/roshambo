#Author: John La Barge

express = require('express')
app = express()
#serve static assets
app.use(express.static(__dirname + '/public'))
#add jade templates
app.configure () ->
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'

#Main Game model simple object. 
game=
   signs: ['rock','paper','scissors']
   #computer throw
   throw: () ->
     random = Math.floor(Math.random()*3)
     this.signs[random]
   #do the scoring
   pickWinner: (my_sign,your_sign) ->
     result_table =
       "rock" : #my sign
         "rock" : "tie", #opponent's sign
         "scissors" : "lose",
         "paper"    : "win",
       "paper" :
         "paper" : "tie",
         "scissors" : "win",
         "rock"     : "lose",
       "scissors" :
         "scissors" : "tie",
         "paper"    : "lose",
         "rock"     : "win"
     result_table[my_sign][your_sign]
   #basic result message 
   getResultText : (mySign, yourSign, result) ->
       if result == "tie" then "We tie." else "You #{result}"
   #play the game    
   play: (yourSign) ->
       tricky =
           "Message" : "You tried to trick me."
        return tricky unless yourSign
        mySign = this.throw()
        result = this.pickWinner(mySign,yourSign)
        console.log(this.getResultText(mySign,yourSign,result))
       
        "Result"   : result
        "Computer" : mySign
        "Player"   : yourSign
        "Message"  : this.getResultText(mySign,yourSign,result)

#Create a base endpoint for starting the game 
app.get '/', (req,res) ->
   res.render('roshambo',{})

#Web service endpoints use ".json"
#use a url param or a query param
app.get '/throw.json/:sign', (req,resp) ->
   throwJson(req.params.sign,resp)

app.get '/throw.json',(req,resp) ->
   throwJson(req.query.sign,resp)

#respond with json
throwJson = (player,res) ->
   result = game.play(player)
   res.json(result)

#HTML endpoints no extension
#use a url param or a query param
app.get '/throw', (req,res) ->
    throwHtml(req.query.sign,res)

app.get '/throw/:sign', (req,res) ->
    throwHtml(req.params.sign,res)

#Respond with html
throwHtml  = (player,res)->
    result = game.play(player)
    res.render('roshambo',result)

      
app.listen(8888)

