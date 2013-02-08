express = require('express')
app = express()
app.use(express.static(__dirname + '/public'))
app.configure () ->
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'

game=
   signs: ['rock','paper','scissors']
   throw: () ->
     random = Math.floor(Math.random()*3)
     this.signs[random]

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
   
   getResultText : (mySign, yourSign, result) ->
       if result == "tie" then "We tie." else "You #{result}"
    
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

   
app.get '/', (req,res) ->
   res.render('roshambo',{})

app.get '/throw.json/:sign', (req,resp) ->
   throwJson(req.params.sign,resp)

app.get '/throw.json',(req,resp) ->
   throwJson(req.query.sign,resp)

throwJson = (player,res) ->
   result = game.play(player)
   res.json(result)

app.get '/throw', (req,res) ->
    throwHtml(req.query.sign,res)

app.get '/throw/:sign', (req,res) ->
    throwHtml(req.params.sign,res)

app.get '/test', (req, res)->
   render('roshambo', {})

throwHtml  = (player,res)->
    result = game.play(player)
    res.render('roshambo',result)

      
app.listen(8888)

