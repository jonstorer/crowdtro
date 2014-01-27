path = require('path')

module.exports =
  login: (req, res) ->
    res.render 'login', { message: req.flash 'error' }

  logout: (req, res) ->
    req.logout()
    delete req.session.company
    delete req.session.passport
    res.redirect('/login')
