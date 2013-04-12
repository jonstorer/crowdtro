path = require('path')

module.exports =
  show: (req, res) ->
    res.status(200).sendfile path.join __dirname, '..', 'public', 'index.html'

  login: (req, res) ->
    res.status(200).sendfile path.join __dirname, '..', 'public', 'login.html'

  logout: (req, res) ->
    req.logout()
    res.redirect('/')
