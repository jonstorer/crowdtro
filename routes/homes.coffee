path = require('path')

module.exports.show = (req, res, next) ->
  res.render 'show'

module.exports.login = (req, res, next) ->
  res.render 'login', { message: req.flash 'error' }

module.exports.logout = (req, res, next) ->
  req.logout()
  delete req.session.passport
  res.redirect('/login')
