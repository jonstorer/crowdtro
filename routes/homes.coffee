path = require('path')

module.exports =
  show: (req, res) ->
    res.status(200).sendfile path.join __dirname, '..', 'public', 'index.html'

  login: (req, res) ->
    res.render 'login', { message: req.flash 'error' }

  logout: (req, res) ->
    req.logout()
    delete req.session.passport
    res.redirect('/login')
